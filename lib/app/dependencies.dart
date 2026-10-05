import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../features/auth/data/firebase_auth_data_source.dart';
import '../features/auth/data/firebase_auth_repository.dart';
import '../features/auth/domain/auth_repository.dart';

/// Composition root: concrete SDK clients are wired here, never in ViewModels.
class AppDependencies {
  AppDependencies({required this.auth});
  final AuthRepository auth;
  factory AppDependencies.firebase() => AppDependencies(auth: FirebaseAuthRepository(
    FirebaseAuthDataSource(FirebaseAuth.instance, FirebaseFirestore.instance, FirebaseStorage.instance)));
}
