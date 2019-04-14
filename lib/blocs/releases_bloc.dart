import 'dart:async';

import 'package:rocket/blocs/common_bloc.dart';
import 'package:rocket/data/releases_data.dart';
import 'package:rocket/models/releases.dart';

class ReleasesBloc extends BaseBloc {
  static final ReleasesBloc _instance = ReleasesBloc();

  final ReleasesRepository _repository = ReleasesRepository.getInstance();

  List<ReleaseModel> getAllReleases() => _repository.getReleases();

  static ReleasesBloc getInstance() => _instance;

  Future<void> load() => _repository.load();

  bool isLoaded() => _repository.isLoaded();

  ReleaseModel findRelease(Platform platform, String name) {
    List<ReleaseModel> list = getAllReleases().where((test) {
      return test.platform == platform && test.version == name;
    }).toList();
    return list.isNotEmpty ? list.first : null;
  }

  List<ReleaseFeatureModel> getFeatures() => _repository.getFeatures();

  List<ReleaseModel> findAndroidReleases() {
    return getAllReleases().where((test) {
      return test.platform == Platform.Android;
    }).toList();
  }

  List<ReleaseModel> findIOsReleases() {
    return getAllReleases().where((test) {
      return test.platform == Platform.iOS;
    }).toList();
  }

  List<ReleaseCheckPoint> buildCheckPointFor(ReleaseModel model) {
    List<ReleaseCheckPoint> result = List<ReleaseCheckPoint>();
    result.add(ReleaseCheckPoint(
      name: "",
      dateTime: model.checkDate,
      isFall: true,
    ));
    result.add(ReleaseCheckPoint(
      name: "",
      dateTime: model.featureFreezeDate,
      isFall: false,
    ));
    result.add(ReleaseCheckPoint(
      name: "",
      dateTime: model.betaStartDate,
      isFall: false,
    ));
    result.add(ReleaseCheckPoint(
      name: "",
      dateTime: model.publishDate,
      isFall: false,
    ));
    result.add(ReleaseCheckPoint(
      name: "",
      dateTime: model.publishCompleteDate,
      isFall: false,
    ));
    return result;
  }

  @override
  void dispose() {}
}
