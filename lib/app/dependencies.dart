import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../features/auth/data/firebase_auth_data_source.dart';
import '../features/auth/data/firebase_auth_repository.dart';
import '../features/auth/domain/auth_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../features/profile/domain/profile_repository.dart';
import '../features/profile/data/profile_data_sources.dart';
import '../features/profile/data/firebase_profile_repository.dart';

/// Composition root: concrete SDK clients are wired here, never in ViewModels.
class AppDependencies {
  AppDependencies({required this.auth, required this.profiles});
  final AuthRepository auth;
  final ProfileRepository profiles;
  factory AppDependencies.firebase() {
    final auth = FirebaseAuthRepository(FirebaseAuthDataSource(
      FirebaseAuth.instance, FirebaseFirestore.instance, FirebaseStorage.instance));
    return AppDependencies(auth: auth, profiles: FirebaseProfileRepository(
      FirestoreProfilesDataSource(FirebaseFirestore.instance, FirebaseMessaging.instance),
      FirebaseProfileStorageDataSource(FirebaseStorage.instance), auth));
  }
}
