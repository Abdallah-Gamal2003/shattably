import '../../../core/errors/app_failure.dart';
import 'auth_repository.dart';

class WatchAuthSession {
  const WatchAuthSession(this.repository);
  final AuthRepository repository;
  Stream<AuthUser?> call() => repository.watchSession();
}
class SignIn {
  const SignIn(this.repository);
  final AuthRepository repository;
  Future<AuthUser> call(String email, String password) {
    if (email.trim().isEmpty || password.isEmpty) {
      throw const AppFailure('validation', 'Email and password are required.');
    }
    return repository.signIn(email.trim(), password);
  }
}
class RegisterAccount {
  const RegisterAccount(this.repository);
  final AuthRepository repository;
  Future<void> call(Registration input) {
    if ([input.name, input.email, input.phone, input.city, input.job, input.address]
        .any((value) => value.trim().isEmpty)) {
      throw const AppFailure('validation', 'Complete all required account details.');
    }
    return repository.register(input);
  }
}
class SendVerificationEmail {
  const SendVerificationEmail(this.repository);
  final AuthRepository repository;
  Future<void> call() => repository.sendVerification();
}
class SendPasswordReset {
  const SendPasswordReset(this.repository);
  final AuthRepository repository;
  Future<void> call(String email) {
    if (!email.contains('@')) throw const AppFailure('validation', 'Enter a valid email.');
    return repository.resetPassword(email.trim());
  }
}
class SignOut {
  const SignOut(this.repository);
  final AuthRepository repository;
  Future<void> call() => repository.signOut();
}
