import 'package:taximeter/modules/inapp_self_upgrade/domain/entity/version_local_log.dart';

class VersionLocalLogModel {
  final String version;
  final int buildNumber;
  final bool isSkipped;
  final DateTime timestamp;

  VersionLocalLogModel({
    required this.version,
    required this.buildNumber,
    required this.isSkipped,
    required this.timestamp,
  });

  factory VersionLocalLogModel.fromJson(Map<String, dynamic> json) {
    return VersionLocalLogModel(
      version: json['version'],
      buildNumber: json['buildNumber'],
      isSkipped: json['isSkipped'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'buildNumber': buildNumber,
      'isSkipped': isSkipped,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  VersionLocalLog toEntity() {
    return VersionLocalLog(
      version: version,
      buildNumber: buildNumber,
      isSkipped: isSkipped,
      timestamp: timestamp,
    );
  }

  VersionLocalLogModel.fromEntity(VersionLocalLog entity)
    : version = entity.version,
      buildNumber = entity.buildNumber,
      isSkipped = entity.isSkipped,
      timestamp = entity.timestamp;
}
