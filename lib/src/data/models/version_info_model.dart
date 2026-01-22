import 'package:inapp_self_upgrade/inapp_self_upgrade.dart';

class VersionInfoModel {
  double version;
  final bool mustTo;
  final int buildNumber;
  final String? releaseNotes;
  final String? downloadUrl;
  final String versionString;

  VersionInfoModel({
    required this.version,
    required this.mustTo,
    required this.buildNumber,
    required this.versionString,
    this.releaseNotes,
    this.downloadUrl,
  });

  /// Create AppVersion from JSON / Map
  factory VersionInfoModel.fromJson(Map<String, dynamic> json) {
    return VersionInfoModel(
      version: (json['version'] as num).toDouble(),
      versionString: json['versionString'] as String,
      mustTo: json['mustTo'] as bool,
      buildNumber: json['buildNumber'] as int,
      releaseNotes: json['releaseNotes'] as String?,
      downloadUrl: json['downloadUrl'] as String?,
    );
  }

  VersionInfo toEntity() {
    return VersionInfo(
      version: versionString,
      forceUpdate: mustTo,
      buildNumber: buildNumber,
      releaseNotes: releaseNotes ?? "",
      downloadUrl: downloadUrl ?? "",
    );
  }
}
