import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shattably/core/errors/app_failure.dart';
import 'package:shattably/features/profile/domain/profile_repository.dart';
import 'package:shattably/features/profile/presentation/edit_profile_screen.dart';

class PendingProfileRepository implements ProfileRepository {
  final pending = Completer<UserProfile>();
  @override
  Future<UserProfile> updateProfile(ProfileChanges changes) => pending.future;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets(
      'Profile editing survives loading and failure rebuilds without resetting input',
      (tester) async {
    final repository = PendingProfileRepository();
    const profile = UserProfile(
        id: 'owner',
        email: 'reader@example.invalid',
        name: 'Original',
        phone: 'example',
        address: 'example',
        job: 'مستخدم',
        city: 'example',
        whatsapp: 'example',
        image: '');
    await tester.pumpWidget(RepositoryProvider<ProfileRepository>.value(
        value: repository,
        child: const MaterialApp(home: EditProfileScreen(profile: profile))));
    await tester.enterText(find.byType(TextFormField).first, 'Edited name');
    await tester.ensureVisible(find.text('Update Profile'));
    await tester.tap(find.text('Update Profile'));
    await tester.pump();
    expect(find.text('Edited name'), findsOneWidget);
    repository.pending
        .completeError(const AppFailure('offline', 'Please retry'));
    await tester.pumpAndSettle();
    expect(find.text('Edited name'), findsOneWidget);
    expect(find.text('Please retry'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
