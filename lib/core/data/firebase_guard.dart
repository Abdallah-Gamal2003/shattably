import 'package:firebase_core/firebase_core.dart';
import '../errors/app_failure.dart';

AppFailure mapFailure(Object error) {
  if (error is AppFailure) return error;
  if (error is FirebaseException) {
    return AppFailure(error.code, switch (error.code) {
      'permission-denied' => 'You do not have permission for this operation.',
      'unavailable' || 'network-request-failed' => 'Connection unavailable. Please retry.',
      'email-already-in-use' => 'An account already exists for this email.',
      'weak-password' => 'Choose a stronger password.',
      'invalid-credential' || 'wrong-password' || 'user-not-found' => 'Email or password is incorrect.',
      _ => 'The operation could not be completed. Please retry.',
    });
  }
  return const AppFailure('unexpected', 'The operation could not be completed.');
}

Future<T> firebaseGuard<T>(Future<T> Function() operation) async {
  try { return await operation(); } catch (error) { throw mapFailure(error); }
}
