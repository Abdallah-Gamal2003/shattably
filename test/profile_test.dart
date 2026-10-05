import 'package:flutter_test/flutter_test.dart';
import 'package:shattably/features/auth/domain/auth_repository.dart';
import 'package:shattably/features/profile/data/firebase_profile_repository.dart';
import 'package:shattably/features/profile/data/profile_data_sources.dart';
import 'package:shattably/features/profile/domain/profile_repository.dart';
import 'package:shattably/features/profile/domain/profile_use_cases.dart';
import 'package:shattably/core/errors/app_failure.dart';

class ProfileAuth implements AuthRepository {
  @override
  AuthUser get currentUser => const AuthUser(id: 'owner', email: 'reader@example.invalid', emailVerified: true);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
class MemoryProfiles implements FirestoreProfilesDataSource {
  final fields = <String,dynamic>{'fcm': ['existing-device'], 'email': 'reader@example.invalid', 'isEmailVerified': true};
  @override
  Future<void> update(String id, Map<String,dynamic> patch) async { fields.addAll(patch); }
  @override
  Future<UserProfile> get(String id) async => profileFromMap(id, fields);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
class MemoryStorage implements FirebaseProfileStorageDataSource {
  @override
  Future<String> upload(String id, String path) async => 'https://example.invalid/avatar';
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
void main() {
  test('Profile update preserves identity, verification and existing device tokens', () async {
    final source = MemoryProfiles();
    final repository = FirebaseProfileRepository(source, MemoryStorage(), ProfileAuth());
    await UpdateProfile(repository)(const ProfileChanges(name:' New name ', phone:'example', address:'example',
      job:'مستخدم', city:'example', whatsapp:''));
    expect(source.fields['name'], 'New name');
    expect(source.fields['fcm'], ['existing-device']);
    expect(source.fields['email'], 'reader@example.invalid');
    expect(source.fields['isEmailVerified'], true);
    await UpdateProfilePhoto(repository)('local-test-image');
    expect(source.fields['image'], 'https://example.invalid/avatar');
    expect(source.fields['fcm'], ['existing-device']);
  });
  test('Invalid profile fields fail before a data-source write', () async {
    final source = MemoryProfiles();
    final update = UpdateProfile(FirebaseProfileRepository(source, MemoryStorage(), ProfileAuth()));
    expect(() => update(const ProfileChanges(name:'',phone:'',address:'',job:'',city:'',whatsapp:'')),
      throwsA(isA<AppFailure>()));
    expect(source.fields.containsKey('name'), false);
  });
}
