import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:rocket/data/releases_data_provider.dart';
import 'package:rocket/models/releases.dart';

class ReleasesRepository {
  static final _dateFormatter = new DateFormat('dd.MM.yyyy');
  static final _instance = ReleasesRepository(AssetsReleasesDataProvider());

  List<ReleaseModel> _releases;
  List<ReleaseFeatureModel> _features;

  final ReleasesDataProvider dataProvider;

  ReleasesRepository(this.dataProvider);

  static ReleasesRepository getInstance() => _instance;

  Future<void> _init() async {
    if (_releases == null) {
      List<ReleaseModel> list = await _parseReleases();
      _releases = list;
    }
    if (_features == null) {
      List<ReleaseFeatureModel> list = await _parseFeatures();
      _features = list;
    }
  }

  Future<List<ReleaseModel>> _parseReleases() async {
    return dataProvider
        .provideScheduleForPlatform(Platform.Android)
        .then((value) {
      Map<String, dynamic> map = json.decode(value);
      List<dynamic> list = map["releases"];
      List<ReleaseModel> result = List<ReleaseModel>();
      for (final item in list) {
        result.add(_parseReleaseModel(item));
      }
      return result;
    });
  }

  bool isLoaded() => _releases != null && _features != null;

  Future<void> load() async {
    await _init();
  }

  Future<List<ReleaseFeatureModel>> _parseFeatures() async {
    return dataProvider.provideFeaturesForRelease(null).then((value) {
      Map<String, dynamic> map = json.decode(value);
      List<ReleaseFeatureModel> result = List<ReleaseFeatureModel>();
      // итерация по командам
      map.forEach((key, value) {
        // итерация по фичам
        Map<String, dynamic> features = value["features"];
        features.forEach((featureKey, featureValue) {
          ReleaseFeatureModel featureModel = ReleaseFeatureModel();
          featureModel.name = key;
          featureModel.desc = featureKey;
          featureModel.developmentStatus = featureValue["development_status"];
          featureModel.metricStatus = featureValue["metric_status"];
          featureModel.uiTests = featureValue["ui_tests"];

          Map<String, dynamic> analyticMap = featureValue["feature_analitic"];
          featureModel.analytic = ReleaseFeatureAnalytic(
            name: analyticMap["name"],
            url: analyticMap["url"],
          );
          Map<String, dynamic> designMap = featureValue["feature_design"];
          featureModel.design = ReleaseFeatureDesign(
            url: designMap["url"],
            name: designMap["name"],
          );
          result.add(featureModel);
        });
      });
      return result;
    });
  }

  List<ReleaseModel> getReleases() => _releases;

  List<ReleaseFeatureModel> getFeatures() => _features;

  ReleaseModel _parseReleaseModel(Map<String, dynamic> item) {
    return ReleaseModel(
        _getPlatformByName(item["platform"]),
        item["version"],
        getSafeDateTime(item["date_check"]),
        getSafeDateTime(item["date_feature_freeze"]),
        getSafeDateTime(item["beta_start"]),
        getSafeDateTime(item["publish_date"]),
        getSafeDateTime(item["publish_complete_date"]),
        item["feature_list_url"]);
  }

  Platform _getPlatformByName(String name) {
    if ('Android' == name) {
      return Platform.Android;
    } else if ('iOS' == name) {
      return Platform.iOS;
    } else {
      return Platform.Unknown;
    }
  }

  DateTime getSafeDateTime(String value) {
    if (value == null || value == "") {
      return null;
    }
    return _dateFormatter.parse(value);
  }
}
