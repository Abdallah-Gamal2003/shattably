class UserProfile {
  const UserProfile(
      {required this.id,
      required this.email,
      required this.name,
      required this.phone,
      required this.address,
      required this.job,
      required this.city,
      required this.whatsapp,
      required this.image});
  final String id, email, name, phone, address, job, city, whatsapp, image;
  bool get isCustomer => job == 'مستخدم';
}

/// Editable fields deliberately exclude identity, verification and push tokens.
class ProfileChanges {
  const ProfileChanges(
      {required this.name,
      required this.phone,
      required this.address,
      required this.job,
      required this.city,
      required this.whatsapp});
  final String name, phone, address, job, city, whatsapp;
}

abstract interface class ProfileRepository {
  Future<UserProfile> getMyProfile();
  Future<UserProfile> getProfile(String id);
  Future<UserProfile> updateProfile(ProfileChanges changes);
  Future<UserProfile> updatePhoto(String path);
}
