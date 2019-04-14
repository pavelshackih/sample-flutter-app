import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:rocket/models/releases.dart';

abstract class ReleasesDataProvider {
  Future<String> provideFeaturesForRelease(String release);

  Future<String> provideScheduleForPlatform(Platform platform);
}

class AssetsReleasesDataProvider implements ReleasesDataProvider {
  static final _releasesPath = "assets/json/schedule.json";
  static final _featuresIoS94 = "assets/json/release.json";

  @override
  Future<String> provideFeaturesForRelease(String release) {
    // ignore release parameter for assets provider
    return _loadAsset(_featuresIoS94);
  }

  @override
  Future<String> provideScheduleForPlatform(Platform platform) {
    // ignore platform parameter for assets provider
    return _loadAsset(_releasesPath);
  }

  Future<String> _loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }
}
