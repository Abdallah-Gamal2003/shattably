import 'dart:async';

class AuthUser {
  const AuthUser(
      {required this.id, required this.email, required this.emailVerified});
  final String id;
  final String email;
  final bool emailVerified;
}

/// Registration details are transient input; passwords are never persisted.
class Registration {
  const Registration(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone,
      required this.address,
      required this.city,
      required this.job,
      required this.whatsapp,
      this.photoPath});
  final String email, password, name, phone, address, city, job, whatsapp;
  final String? photoPath;
}

abstract interface class AuthRepository {
  AuthUser? get currentUser;
  Stream<AuthUser?> watchSession();
  Future<AuthUser> signIn(String email, String password);
  Future<void> register(Registration registration);
  Future<void> sendVerification();
  Future<void> resetPassword(String email);
  Future<void> signOut();
}
