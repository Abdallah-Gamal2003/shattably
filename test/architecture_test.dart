import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Domain and ViewModels retain inward dependency boundaries', () {
    for (final feature in ['auth', 'profile', 'orders', 'offers']) {
      for (final file in Directory('lib/features/$feature/domain')
          .listSync()
          .whereType<File>()) {
        final source = file.readAsStringSync();
        expect(source, isNot(contains('package:flutter')), reason: file.path);
        expect(source, isNot(contains('package:firebase')), reason: file.path);
        expect(source, isNot(contains('package:cloud_firestore')),
            reason: file.path);
        expect(source, isNot(contains('/data/')), reason: file.path);
      }
      for (final file in Directory('lib/features/$feature/presentation')
          .listSync()
          .whereType<File>()) {
        final source = file.readAsStringSync();
        expect(source, isNot(contains('package:firebase')), reason: file.path);
        expect(source, isNot(contains('package:cloud_firestore')),
            reason: file.path);
        expect(source, isNot(contains('/data/')), reason: file.path);
        if (file.path.endsWith('_cubits.dart')) {
          expect(source, isNot(contains('BuildContext')), reason: file.path);
          expect(source, isNot(contains('Navigator')), reason: file.path);
          expect(source, isNot(contains('package:flutter/')),
              reason: file.path);
        }
      }
    }
  });
}
