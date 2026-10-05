import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/presentation/load_state.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_use_cases.dart';

class SessionCubit extends Cubit<LoadState<AuthUser>> {
  SessionCubit(WatchAuthSession watch, this.signOut) : super(const LoadState(status: LoadStatus.loading)) {
    _subscription = watch().listen((user) {
      emit(LoadState(status: LoadStatus.success, data: user));
    }, onError: (Object error) {
      emit(LoadState(status: LoadStatus.failure, failure: error is AppFailure ? error :
        const AppFailure('session', 'Unable to restore the session.')));
    });
  }
  final SignOut signOut;
  late final StreamSubscription<AuthUser?> _subscription;
  Future<void> logout() async {
    try { await signOut(); } on AppFailure catch (error) {
      emit(LoadState(status: LoadStatus.failure, data: state.data, failure: error));
    }
  }
  @override
  Future<void> close() async { await _subscription.cancel(); return super.close(); }
}

enum LoginStatus { initial, loading, signedIn, failure, resetSent, verificationSent, visibilityChanged }
class LoginState {
  const LoginState(this.status, {this.user, this.failure, this.obscure = true});
  final LoginStatus status;
  final AuthUser? user;
  final AppFailure? failure;
  final bool obscure;
}
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.signIn, this.reset, this.verify) : super(const LoginState(LoginStatus.initial));
  final SignIn signIn;
  final SendPasswordReset reset;
  final SendVerificationEmail verify;
  bool get isPassword => state.obscure;
  void changePasswordVisibility() => emit(LoginState(LoginStatus.visibilityChanged, obscure: !state.obscure));
  Future<void> userLogin({required String email, required String password}) async {
    if (state.status == LoginStatus.loading) return;
    final obscure = state.obscure;
    emit(LoginState(LoginStatus.loading, obscure: obscure));
    try {
      final user = await signIn(email, password);
      if (!isClosed) emit(LoginState(LoginStatus.signedIn, user: user, obscure: obscure));
    } on AppFailure catch (error) {
      if (!isClosed) emit(LoginState(LoginStatus.failure, failure: error, obscure: obscure));
    }
  }
  Future<void> resetPassword(String email) => _action(() => reset(email), LoginStatus.resetSent);
  Future<void> sendVerification() => _action(verify.call, LoginStatus.verificationSent);
  Future<void> _action(Future<void> Function() action, LoginStatus success) async {
    try { await action(); if (!isClosed) emit(LoginState(success)); }
    on AppFailure catch (error) { if (!isClosed) emit(LoginState(LoginStatus.failure, failure: error)); }
  }
}

class RegisterCubit extends Cubit<LoadState<void>> {
  RegisterCubit(this.register) : super(const LoadState());
  final RegisterAccount register;
  Future<void> submit(Registration input) async {
    if (state.status == LoadStatus.loading) return;
    emit(const LoadState(status: LoadStatus.loading));
    try {
      await register(input);
      if (!isClosed) emit(const LoadState(status: LoadStatus.success));
    } on AppFailure catch (error) {
      if (!isClosed) emit(LoadState(status: LoadStatus.failure, failure: error));
    }
  }
}
