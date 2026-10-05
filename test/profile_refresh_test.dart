import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:shattably/features/profile/domain/profile_repository.dart';
import 'package:shattably/features/profile/domain/profile_use_cases.dart';
import 'package:shattably/features/profile/presentation/profile_cubits.dart';

class DeferredProfiles implements ProfileRepository {
  final requests = <Completer<UserProfile>>[];
  @override
  Future<UserProfile> getMyProfile() {
    final request = Completer<UserProfile>();
    requests.add(request);
    return request.future;
  }
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
void main() {
  const profile = UserProfile(id:'owner',email:'reader@example.invalid',name:'Example',phone:'example',address:'example',job:'مستخدم',city:'example',whatsapp:'',image:'');
  test('Profile refresh preserves data; session reload clears it and ignores stale completions', () async {
    final repository = DeferredProfiles();
    final cubit = ProfileCubit(GetMyProfile(repository));
    addTearDown(cubit.close);
    final initial = cubit.load();
    repository.requests[0].complete(profile);
    await initial;
    final refresh = cubit.load();
    expect(cubit.state.data, profile);
    final session = cubit.load(clear:true);
    expect(cubit.state.data, null);
    repository.requests[1].complete(profile);
    await refresh;
    expect(cubit.state.data, null);
    repository.requests[2].complete(profile);
    await session;
    expect(cubit.state.data, profile);
  });
}
