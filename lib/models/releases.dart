class ReleaseModel {
  final Platform platform;
  final String version;
  final DateTime checkDate;
  final DateTime featureFreezeDate;
  final DateTime betaStartDate;
  final DateTime publishDate;
  final DateTime publishCompleteDate;
  final String featureListUrl;

  const ReleaseModel(
      this.platform,
      this.version,
      this.checkDate,
      this.featureFreezeDate,
      this.betaStartDate,
      this.publishDate,
      this.publishCompleteDate,
      this.featureListUrl);

  @override
  String toString() {
    return 'ReleaseModel{platform: $platform, version: $version, checkDate: $checkDate, featureFreezeDate: $featureFreezeDate, betaStartDate: $betaStartDate, publishDate: $publishDate, publishCompleteDate: $publishCompleteDate, featureListUrl: $featureListUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReleaseModel &&
          runtimeType == other.runtimeType &&
          platform == other.platform &&
          version == other.version &&
          checkDate == other.checkDate &&
          featureFreezeDate == other.featureFreezeDate &&
          betaStartDate == other.betaStartDate &&
          publishDate == other.publishDate &&
          publishCompleteDate == other.publishCompleteDate &&
          featureListUrl == other.featureListUrl;

  @override
  int get hashCode =>
      platform.hashCode ^
      version.hashCode ^
      checkDate.hashCode ^
      featureFreezeDate.hashCode ^
      betaStartDate.hashCode ^
      publishDate.hashCode ^
      publishCompleteDate.hashCode ^
      featureListUrl.hashCode;
}

class ReleaseCheckPoint {
  final String name;
  final DateTime dateTime;
  final bool isFall;

  ReleaseCheckPoint({this.name, this.dateTime, this.isFall});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReleaseCheckPoint &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          dateTime == other.dateTime &&
          isFall == other.isFall;

  @override
  int get hashCode => name.hashCode ^ dateTime.hashCode ^ isFall.hashCode;

  @override
  String toString() {
    return 'ReleaseCheckPoint{name: $name, dateTime: $dateTime, isFall: $isFall}';
  }
}

class ReleaseFeatureModel {
  String name;
  String desc;
  String metricStatus;
  String uiTests;
  String developmentStatus;
  ReleaseFeatureAnalytic analytic;
  ReleaseFeatureDesign design;

  ReleaseFeatureModel(
      {this.name,
      this.desc,
      this.metricStatus,
      this.uiTests,
      this.developmentStatus,
      this.analytic,
      this.design});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReleaseFeatureModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          desc == other.desc &&
          metricStatus == other.metricStatus &&
          uiTests == other.uiTests &&
          developmentStatus == other.developmentStatus &&
          analytic == other.analytic &&
          design == other.design;

  @override
  int get hashCode =>
      name.hashCode ^
      desc.hashCode ^
      metricStatus.hashCode ^
      uiTests.hashCode ^
      developmentStatus.hashCode ^
      analytic.hashCode ^
      design.hashCode;

  @override
  String toString() {
    return 'ReleaseFeatureModel{name: $name, desc: $desc, metricStatus: $metricStatus, uiTests: $uiTests, developmentStatus: $developmentStatus, analytic: $analytic, design: $design}';
  }
}

class ReleaseFeatureAnalytic {
  final String name;
  final String url;

  ReleaseFeatureAnalytic({this.name, this.url});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReleaseFeatureAnalytic &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          url == other.url;

  @override
  int get hashCode => name.hashCode ^ url.hashCode;

  @override
  String toString() {
    return 'ReleaseFeatureAnalytic{name: $name, url: $url}';
  }
}

class ReleaseFeatureDesign {
  final String name;
  final String url;

  ReleaseFeatureDesign({this.name, this.url});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReleaseFeatureDesign &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          url == other.url;

  @override
  int get hashCode => name.hashCode ^ url.hashCode;

  @override
  String toString() {
    return 'ReleaseFeatureDesign{name: $name, url: $url}';
  }
}

class Command {
  final String name;

  Command(this.name);
}

enum Platform { Android, iOS, Unknown }
