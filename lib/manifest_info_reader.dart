import 'src/manifest_info_reader_platform_interface.dart';

/// A Flutter plugin that provides access to platform-specific configuration files:
///
/// - iOS: info.plist
/// - Android: AndroidManifest.xml
class ManifestInfoReader {
  /// Gets a specific value from platform configuration files.
  ///
  /// On iOS, this reads from info.plist.
  /// On Android, this reads from AndroidManifest.xml.
  ///
  /// Example:
  /// ```dart
  /// // iOS
  /// final String? appName = await ManifestInfoReader.getValue('CFBundleName');
  ///
  /// // Android
  /// final String? appName = await ManifestInfoReader.getValue('app_name');
  /// ```
  static Future<String?> getValue(String key) {
    return ManifestInfoReaderPlatform.instance.getValue(key);
  }

  /// Gets all values from iOS info.plist file.
  ///
  /// Returns null on Android platforms.
  ///
  /// Example:
  /// ```dart
  /// final Map<String, dynamic>? iosValues = await ManifestInfoReader.getInfoPlistValues();
  /// ```
  static Future<Map<String, dynamic>?> getInfoPlistValues() {
    return ManifestInfoReaderPlatform.instance.getInfoPlistValues();
  }

  /// Gets all accessible values from Android AndroidManifest.xml.
  ///
  /// Returns null on iOS platforms.
  ///
  /// Example:
  /// ```dart
  /// final Map<String, dynamic>? androidValues = await ManifestInfoReader.getAndroidManifestXmlValues();
  /// ```
  static Future<Map<String, dynamic>?> getAndroidManifestXmlValues() {
    return ManifestInfoReaderPlatform.instance.getAndroidManifestXmlValues();
  }

  /// Gets all configuration values based on the current platform.
  ///
  /// On iOS, returns values from info.plist.
  /// On Android, returns values from AndroidManifest.xml.
  ///
  /// Example:
  /// ```dart
  /// final Map<String, dynamic>? values = await ManifestInfoReader.getValues();
  /// ```
  static Future<Map<String, dynamic>?> getValues() {
    return ManifestInfoReaderPlatform.instance.getValues();
  }
}
