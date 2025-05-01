import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manifest_info_reader/src/manifest_info_reader_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelManifestInfoReader platform = MethodChannelManifestInfoReader();
  const MethodChannel channel = MethodChannel('manifest_info_reader');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          switch (methodCall.method) {
            case 'getValue':
              return 'test_value';
            case 'getInfoPlistValues':
              return {'CFBundleName': 'TestApp', 'CFBundleVersion': '1.0.0'};
            case 'getAndroidManifestXmlValues':
              return {'app_name': 'TestApp', 'version_name': '1.0.0'};
            default:
              return null;
          }
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getValue', () async {
    expect(await platform.getValue('test_key'), 'test_value');
  });

  test('getInfoPlistValues', () async {
    final result = await platform.getInfoPlistValues();
    expect(result, isA<Map<String, dynamic>>());
    expect(result?['CFBundleName'], 'TestApp');
  });

  test('getAndroidManifestXmlValues', () async {
    final result = await platform.getAndroidManifestXmlValues();
    expect(result, isA<Map<String, dynamic>>());
    expect(result?['app_name'], 'TestApp');
  });
}
