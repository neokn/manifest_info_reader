// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:manifest_info_reader/manifest_info_reader.dart'
    show ManifestInfoReader;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getValue test', (WidgetTester tester) async {
    // Test getting a value that should exist on both platforms
    final String? value = await ManifestInfoReader.getValue('app_name');
    // The value depends on the host platform running the test, so
    // just assert that some non-empty string is returned.
    expect(value?.isNotEmpty, true);
  });

  testWidgets('getInfoPlistValues test on iOS', (WidgetTester tester) async {
    // This test will only return meaningful results on iOS
    final Map<String, dynamic>? values =
        await ManifestInfoReader.getInfoPlistValues();
    // On iOS, this should return a non-empty map
    // On Android, this should return null
    if (values != null) {
      expect(values.isNotEmpty, true);
    }
  });

  testWidgets('getAndroidManifestXmlValues test on Android', (
    WidgetTester tester,
  ) async {
    // This test will only return meaningful results on Android
    final Map<String, dynamic>? values =
        await ManifestInfoReader.getAndroidManifestXmlValues();
    // On Android, this should return a non-empty map
    // On iOS, this should return null
    if (values != null) {
      expect(values.isNotEmpty, true);
    }
  });
}
