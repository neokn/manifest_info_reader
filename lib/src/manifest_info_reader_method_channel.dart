import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'manifest_info_reader_platform_interface.dart';

/// An implementation of [ManifestInfoReaderPlatform] that uses method channels.
class MethodChannelManifestInfoReader extends ManifestInfoReaderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('manifest_info_reader');

  @override
  Future<String?> getValue(String key) async {
    try {
      final value = await methodChannel.invokeMethod<String>('getValue', {
        'key': key,
      });
      return value;
    } on PlatformException catch (e) {
      debugPrint('Error getting value for key $key: ${e.message}');
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> getInfoPlistValues() async {
    try {
      final result = await methodChannel.invokeMethod<Map<Object?, Object?>>(
        'getInfoPlistValues',
      );
      if (result == null) return null;

      // Convert Map<Object?, Object?> to Map<String, dynamic>
      return result.map((key, value) => MapEntry(key.toString(), value));
    } on PlatformException catch (e) {
      debugPrint('Error getting info.plist values: ${e.message}');
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> getAndroidManifestXmlValues() async {
    try {
      final result = await methodChannel.invokeMethod<Map<Object?, Object?>>(
        'getAndroidManifestXmlValues',
      );
      if (result == null) return null;

      // Convert Map<Object?, Object?> to Map<String, dynamic>
      return result.map((key, value) => MapEntry(key.toString(), value));
    } on PlatformException catch (e) {
      debugPrint('Error getting AndroidManifest.xml values: ${e.message}');
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> getValues() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return getInfoPlistValues();
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return getAndroidManifestXmlValues();
    }
    return null;
  }
}
