# manifest_info_reader

Manifest Info Reader is a Flutter plugin that allows you to read native app configuration files across platforms (iOS and Android):
- iOS: info.plist
- Android: AndroidManifest.xml

## Features
- Retrieve specific key values
- Retrieve all iOS info.plist values
- Retrieve all Android AndroidManifest.xml values
- Simple and unified API

## Supported Platforms
- Android
- iOS

## Installation
Add to your `pubspec.yaml`:
```yaml
dependencies:
  manifest_info_reader: ^0.0.1
```

Run `flutter pub get` to install.

## Usage
```dart
import 'package:manifest_info_reader/manifest_info_reader.dart';

void example() async {
  // Get a specific key
  final value = await ManifestInfoReader.getValue('app_name');

  // Get all iOS info.plist values
  final iosValues = await ManifestInfoReader.getInfoPlistValues();

  // Get all AndroidManifest.xml values
  final androidValues = await ManifestInfoReader.getAndroidManifestXmlValues();
}
```

## API
- `Future<String?> getValue(String key)`: Get the value for a specific key.
- `Future<Map<String, dynamic>?> getInfoPlistValues()`: Get all values from iOS info.plist.
- `Future<Map<String, dynamic>?> getAndroidManifestXmlValues()`: Get all values from AndroidManifest.xml.
- `Future<Map<String, dynamic>?> getValues()`: Get all configuration values based on the current platform.

## Contribution
Pull requests and issues are welcome!

## License
MIT License

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
