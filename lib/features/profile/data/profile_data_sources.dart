import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shattably/core/errors/app_failure.dart';
import 'package:shattably/features/profile/domain/profile_repository.dart';

UserProfile profileFromMap(String id, Map<String, dynamic> data) => UserProfile(
    id: id,
    email: data['email'] as String? ?? '',
    name: data['name'] as String? ?? '',
    phone: data['phone'] as String? ?? '',
    address: data['address'] as String? ?? '',
    city: data['city'] as String? ?? '',
    job: data['job'] as String? ?? '',
    whatsapp: data['whatsapp'] as String? ?? '',
    image: data['image'] as String? ?? '');

Map<String, dynamic> editableProfileFields(ProfileChanges changes) => {
      'name': changes.name.trim(),
      'phone': changes.phone.trim(),
      'address': changes.address.trim(),
      'job': changes.job,
      'city': changes.city,
      'whatsapp': changes.whatsapp.trim(),
    };

class FirestoreProfilesDataSource {
  FirestoreProfilesDataSource(this.firestore, this.messaging);
  final FirebaseFirestore firestore;
  final FirebaseMessaging messaging;
  Future<UserProfile> get(String id) async {
    final document = await firestore.collection('profiles').doc(id).get();
    if (!document.exists)
      throw const AppFailure(
          'profile-missing', 'Profile setup is incomplete. Contact support.');
    return profileFromMap(id, document.data()!);
  }

  Future<void> update(String id, Map<String, dynamic> fields) =>
      firestore.collection('profiles').doc(id).update(fields);
  Future<void> registerDevice(String id) async {
    final token = await messaging.getToken();
    if (token != null && token.isNotEmpty) {
      await update(id, {
        'fcm': FieldValue.arrayUnion([token])
      });
    }
  }
}

class FirebaseProfileStorageDataSource {
  FirebaseProfileStorageDataSource(this.storage);
  final FirebaseStorage storage;
  Future<String> upload(String id, String path) async {
    final reference = storage
        .ref('profiles/$id/avatar-${DateTime.now().microsecondsSinceEpoch}');
    await reference.putFile(File(path));
    return reference.getDownloadURL();
  }
}
