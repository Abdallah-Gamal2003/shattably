import '../../../core/data/firebase_guard.dart';
import '../../../core/errors/app_failure.dart';
import '../domain/auth_repository.dart';
import 'firebase_auth_data_source.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this.source);
  final FirebaseAuthDataSource source;
  @override
  AuthUser? get currentUser => source.currentUser;
  @override
  Stream<AuthUser?> watchSession() => source.watchSession().handleError((Object error) {
    throw mapFailure(error);
  });
  @override
  Future<AuthUser> signIn(String email, String password) => firebaseGuard(() => source.signIn(email, password));
  @override
  Future<void> register(Registration input) => firebaseGuard(() async {
    final id = await source.createAccount(input);
    try {
      await source.createProfile(id, input);
    } catch (_) {
      // Auth and Firestore cannot share a transaction. Compensate explicitly.
      try {
        await source.deleteCreatedAccount();
      } catch (_) {
        await source.signOut();
        throw const AppFailure('registration-recovery-required',
          'Account setup failed and rollback could not finish. Contact support before retrying.');
      }
      throw const AppFailure('profile-creation-failed', 'Account setup failed. Please retry registration.');
    }
    try {
      await source.sendVerification();
    } catch (_) {
      await source.signOut();
      throw const AppFailure('verification-delivery-failed',
        'Account created. Sign in and resend the verification email.');
    }
    await source.signOut();
  });
  @override
  Future<void> sendVerification() => firebaseGuard(source.sendVerification);
  @override
  Future<void> resetPassword(String email) => firebaseGuard(() => source.resetPassword(email));
  @override
  Future<void> signOut() => firebaseGuard(source.signOut);
}
