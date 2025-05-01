import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'manifest_info_reader_method_channel.dart';

abstract class ManifestInfoReaderPlatform extends PlatformInterface {
  /// Constructs a ManifestInfoReaderPlatform.
  ManifestInfoReaderPlatform() : super(token: _token);

  static final Object _token = Object();

  static ManifestInfoReaderPlatform _instance =
      MethodChannelManifestInfoReader();

  /// The default instance of [ManifestInfoReaderPlatform] to use.
  ///
  /// Defaults to [MethodChannelManifestInfoReader].
  static ManifestInfoReaderPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ManifestInfoReaderPlatform] when
  /// they register themselves.
  static set instance(ManifestInfoReaderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Gets a specific value from platform configuration files.
  ///
  /// On iOS, this reads from info.plist.
  /// On Android, this reads from AndroidManifest.xml.
  Future<String?> getValue(String key) {
    throw UnimplementedError('getValue() has not been implemented.');
  }

  /// Gets all values from iOS info.plist file.
  ///
  /// Returns null on Android platforms.
  Future<Map<String, dynamic>?> getInfoPlistValues() {
    throw UnimplementedError('getInfoPlistValues() has not been implemented.');
  }

  /// Gets all accessible values from Android AndroidManifest.xml.
  ///
  /// Returns null on iOS platforms.
  Future<Map<String, dynamic>?> getAndroidManifestXmlValues() {
    throw UnimplementedError(
      'getAndroidManifestXmlValues() has not been implemented.',
    );
  }

  /// Gets all configuration values based on the current platform.
  ///
  /// On iOS, returns values from info.plist.
  /// On Android, returns values from AndroidManifest.xml.
  ///
  /// This is a convenience method that automatically calls the appropriate
  /// platform-specific method.
  Future<Map<String, dynamic>?> getValues() {
    throw UnimplementedError('getValues() has not been implemented.');
  }
}
