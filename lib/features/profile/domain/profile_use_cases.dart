import '../../../core/errors/app_failure.dart';
import 'profile_repository.dart';

class GetMyProfile {
  const GetMyProfile(this.repository);
  final ProfileRepository repository;
  Future<UserProfile> call() => repository.getMyProfile();
}
class GetProfile {
  const GetProfile(this.repository);
  final ProfileRepository repository;
  Future<UserProfile> call(String id) => repository.getProfile(id);
}
class UpdateProfile {
  const UpdateProfile(this.repository);
  final ProfileRepository repository;
  Future<UserProfile> call(ProfileChanges changes) {
    if ([changes.name, changes.phone, changes.address, changes.job, changes.city]
        .any((value) => value.trim().isEmpty)) {
      throw const AppFailure('validation', 'Complete the required profile fields.');
    }
    return repository.updateProfile(changes);
  }
}
class UpdateProfilePhoto {
  const UpdateProfilePhoto(this.repository);
  final ProfileRepository repository;
  Future<UserProfile> call(String path) => repository.updatePhoto(path);
}
