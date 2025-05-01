import 'package:flutter_test/flutter_test.dart';
import 'package:manifest_info_reader/manifest_info_reader.dart';
import 'package:manifest_info_reader/src/manifest_info_reader_platform_interface.dart';
import 'package:manifest_info_reader/src/manifest_info_reader_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockManifestInfoReaderPlatform
    with MockPlatformInterfaceMixin
    implements ManifestInfoReaderPlatform {
  @override
  Future<String?> getValue(String key) => Future.value('mock_value');

  @override
  Future<Map<String, dynamic>?> getInfoPlistValues() =>
      Future.value({'CFBundleName': 'MockApp', 'CFBundleVersion': '1.0.0'});

  @override
  Future<Map<String, dynamic>?> getAndroidManifestXmlValues() =>
      Future.value({'app_name': 'MockApp', 'version_name': '1.0.0'});

  @override
  Future<Map<String, dynamic>?> getValues() =>
      Future.value({'app_name': 'MockApp', 'version_name': '1.0.0'});
}

void main() {
  final ManifestInfoReaderPlatform initialPlatform =
      ManifestInfoReaderPlatform.instance;

  test('$MethodChannelManifestInfoReader is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelManifestInfoReader>());
  });

  test('getValue', () async {
    MockManifestInfoReaderPlatform fakePlatform =
        MockManifestInfoReaderPlatform();
    ManifestInfoReaderPlatform.instance = fakePlatform;

    expect(await ManifestInfoReader.getValue('test_key'), 'mock_value');
  });

  test('getInfoPlistValues', () async {
    MockManifestInfoReaderPlatform fakePlatform =
        MockManifestInfoReaderPlatform();
    ManifestInfoReaderPlatform.instance = fakePlatform;

    final result = await ManifestInfoReader.getInfoPlistValues();
    expect(result, isA<Map<String, dynamic>>());
    expect(result?['CFBundleName'], 'MockApp');
  });

  test('getAndroidManifestXmlValues', () async {
    MockManifestInfoReaderPlatform fakePlatform =
        MockManifestInfoReaderPlatform();
    ManifestInfoReaderPlatform.instance = fakePlatform;

    final result = await ManifestInfoReader.getAndroidManifestXmlValues();
    expect(result, isA<Map<String, dynamic>>());
    expect(result?['app_name'], 'MockApp');
  });

  test('getValues', () async {
    MockManifestInfoReaderPlatform fakePlatform =
        MockManifestInfoReaderPlatform();
    ManifestInfoReaderPlatform.instance = fakePlatform;

    final result = await ManifestInfoReader.getValues();
    expect(result, isA<Map<String, dynamic>>());
    expect(result?['app_name'], 'MockApp');
    expect(result?['version_name'], '1.0.0');
  });
}
