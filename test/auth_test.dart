import 'package:flutter_test/flutter_test.dart';
import 'package:shattably/core/errors/app_failure.dart';
import 'package:shattably/features/auth/domain/auth_repository.dart';
import 'package:shattably/features/auth/domain/auth_use_cases.dart';
import 'package:shattably/features/auth/presentation/auth_cubits.dart';
import 'package:shattably/features/auth/data/firebase_auth_repository.dart';
import 'package:shattably/features/auth/data/firebase_auth_data_source.dart';

class FakeAuth implements AuthRepository {
  bool fail = false;
  int calls = 0;
  @override
  Future<AuthUser> signIn(String email, String password) async {
    calls++;
    if (fail)
      throw const AppFailure('invalid-credential', 'Invalid credentials');
    return const AuthUser(
        id: 'customer', email: 'reader@example.invalid', emailVerified: true);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FailingProfileSource implements FirebaseAuthDataSource {
  bool deleted = false;
  bool verificationSent = false;
  bool rollbackFails = false;
  bool signedOut = false;
  @override
  Future<String> createAccount(Registration input) async => 'new-account';
  @override
  Future<void> createProfile(String id, Registration input) async =>
      throw const AppFailure('offline', 'Offline');
  @override
  Future<void> deleteCreatedAccount() async {
    if (rollbackFails) throw const AppFailure('offline', 'Offline');
    deleted = true;
  }

  @override
  Future<void> signOut() async {
    signedOut = true;
  }

  @override
  Future<void> sendVerification() async {
    verificationSent = true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final testPassword = List.filled(12, 'x').join();
  test('Login maps success and failure and signs in only once per submission',
      () async {
    final auth = FakeAuth();
    final cubit = LoginCubit(
        SignIn(auth), SendPasswordReset(auth), SendVerificationEmail(auth));
    addTearDown(cubit.close);
    await cubit.userLogin(
        email: 'reader@example.invalid', password: testPassword);
    expect(cubit.state.status, LoginStatus.signedIn);
    expect(auth.calls, 1);
    auth.fail = true;
    await cubit.userLogin(
        email: 'reader@example.invalid', password: testPassword);
    expect(cubit.state.status, LoginStatus.failure);
    expect(cubit.state.failure!.code, 'invalid-credential');
  });
  test('Password visibility is presentation state without Widgets', () async {
    final auth = FakeAuth();
    final cubit = LoginCubit(
        SignIn(auth), SendPasswordReset(auth), SendVerificationEmail(auth));
    addTearDown(cubit.close);
    cubit.changePasswordVisibility();
    expect(cubit.state.obscure, false);
    cubit.changePasswordVisibility();
    expect(cubit.state.obscure, true);
  });
  final input = Registration(
      email: 'reader@example.invalid',
      password: testPassword,
      name: 'Example',
      phone: 'placeholder',
      address: 'Example',
      city: 'Example',
      job: 'Example',
      whatsapp: '');
  test('Profile creation failure rolls back auth and never reports success',
      () async {
    final source = FailingProfileSource();
    final repository = FirebaseAuthRepository(source);
    await expectLater(
        repository.register(input),
        throwsA(isA<AppFailure>()
            .having((e) => e.code, 'code', 'profile-creation-failed')));
    expect(source.deleted, true);
    expect(source.verificationSent, false);
  });
  test(
      'Failed compensation signs out and exposes a recoverable partial failure',
      () async {
    final source = FailingProfileSource()..rollbackFails = true;
    await expectLater(
        FirebaseAuthRepository(source).register(input),
        throwsA(isA<AppFailure>()
            .having((e) => e.code, 'code', 'registration-recovery-required')));
    expect(source.signedOut, true);
  });
}
