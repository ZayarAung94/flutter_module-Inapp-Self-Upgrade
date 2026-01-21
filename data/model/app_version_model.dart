import 'package:taximeter/modules/inapp_self_upgrade/domain/entity/version_info_entity.dart';

class AppVersion {
  double version;
  final bool mustTo;
  final int buildNumber;
  final String? releaseNotes;
  final String? downloadUrl;
  final String versionString;

  AppVersion({
    required this.version,
    required this.mustTo,
    required this.buildNumber,
    required this.versionString,
    this.releaseNotes,
    this.downloadUrl,
  });

  /// Create AppVersion from JSON / Map
  factory AppVersion.fromJson(Map<String, dynamic> json) {
    return AppVersion(
      version: (json['version'] as num).toDouble(),
      versionString: json['versionString'] as String,
      mustTo: json['mustTo'] as bool,
      buildNumber: json['buildNumber'] as int,
      releaseNotes: json['releaseNotes'] as String?,
      downloadUrl: json['downloadUrl'] as String?,
    );
  }

  VersionInfoEntity toEntity() {
    return VersionInfoEntity(
      version: versionString,
      forceUpdate: mustTo,
      buildNumber: buildNumber,
      releaseNotes: releaseNotes ?? "",
      downloadUrl: downloadUrl ?? "",
    );
  }
}
