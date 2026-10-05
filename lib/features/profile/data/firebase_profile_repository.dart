import '../../../core/data/firebase_guard.dart';
import '../../../core/errors/app_failure.dart';
import '../../auth/domain/auth_repository.dart';
import '../domain/profile_repository.dart';
import 'profile_data_sources.dart';

class FirebaseProfileRepository implements ProfileRepository {
  FirebaseProfileRepository(this.profiles, this.storage, this.auth);
  final FirestoreProfilesDataSource profiles;
  final FirebaseProfileStorageDataSource storage;
  final AuthRepository auth;
  String get _id => auth.currentUser?.id ?? (throw const AppFailure('unauthenticated', 'Please sign in.'));
  @override
  Future<UserProfile> getMyProfile() => firebaseGuard(() async {
    final id = _id;
    final profile = await profiles.get(id);
    // Push registration is best effort and cannot prevent opening a profile.
    try { await profiles.registerDevice(id); } catch (_) { /* Retry on next profile load. */ }
    return profile;
  });
  @override
  Future<UserProfile> getProfile(String id) => firebaseGuard(() => profiles.get(id));
  @override
  Future<UserProfile> updateProfile(ProfileChanges changes) => firebaseGuard(() async {
    final id = _id;
    await profiles.update(id, editableProfileFields(changes));
    return profiles.get(id);
  });
  @override
  Future<UserProfile> updatePhoto(String path) => firebaseGuard(() async {
    final id = _id;
    final url = await storage.upload(id, path);
    await profiles.update(id, {'image': url});
    return profiles.get(id);
  });
}
