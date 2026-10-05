import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shattably/features/auth/domain/auth_repository.dart';

/// SDK boundary, including the legacy profile provisioning required at signup.
class FirebaseAuthDataSource {
  FirebaseAuthDataSource(this.auth, this.firestore, this.storage);
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  AuthUser? mapUser(User? user) => user == null
      ? null
      : AuthUser(
          id: user.uid,
          email: user.email ?? '',
          emailVerified: user.emailVerified);
  AuthUser? get currentUser => mapUser(auth.currentUser);
  Stream<AuthUser?> watchSession() => auth.userChanges().map(mapUser);
  Future<AuthUser> signIn(String email, String password) async => mapUser(
      (await auth.signInWithEmailAndPassword(email: email, password: password))
          .user)!;
  Future<String> createAccount(Registration input) async =>
      (await auth.createUserWithEmailAndPassword(
              email: input.email.trim(), password: input.password))
          .user!
          .uid;
  Future<void> createProfile(String id, Registration input) async {
    var image = '';
    if (input.photoPath != null) {
      final reference = storage.ref('profiles/$id/avatar');
      await reference.putFile(File(input.photoPath!));
      image = await reference.getDownloadURL();
    }
    await firestore.collection('profiles').doc(id).set({
      'uId': id,
      'email': input.email.trim(),
      'name': input.name.trim(),
      'phone': input.phone.trim(),
      'address': input.address.trim(),
      'city': input.city,
      'job': input.job,
      'whatsapp': input.whatsapp.trim(),
      'image': image,
      'isEmailVerified': false,
      'fcm': <String>[],
    });
  }

  Future<void> deleteCreatedAccount() async => auth.currentUser?.delete();
  Future<void> sendVerification() async =>
      auth.currentUser?.sendEmailVerification();
  Future<void> resetPassword(String email) =>
      auth.sendPasswordResetEmail(email: email);
  Future<void> signOut() => auth.signOut();
}
