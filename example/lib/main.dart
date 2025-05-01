import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:manifest_info_reader/manifest_info_reader.dart'
    show ManifestInfoReader;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> _manifestValues = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    initManifestInfo();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initManifestInfo() async {
    Map<String, dynamic> manifestValues = {};

    try {
      // Get all manifest values using the platform-aware method
      manifestValues = await ManifestInfoReader.getValues() ?? {};
    } on PlatformException catch (e) {
      debugPrint('Error reading manifest info: ${e.message}');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _manifestValues = manifestValues;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Manifest Info Reader Example')),
        body:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'All Manifest Values:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child:
                            _manifestValues.isEmpty
                                ? const Center(
                                  child: Text('No manifest values found'),
                                )
                                : ListView.builder(
                                  itemCount: _manifestValues.length,
                                  itemBuilder: (context, index) {
                                    final key = _manifestValues.keys.elementAt(
                                      index,
                                    );
                                    final value = _manifestValues[key];
                                    return Card(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              key,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(value.toString()),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
