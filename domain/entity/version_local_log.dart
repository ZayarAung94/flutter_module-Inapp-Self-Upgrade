class VersionLocalLog {
  final String version;
  final int buildNumber;
  final bool isSkipped;
  final DateTime timestamp;

  VersionLocalLog({
    required this.version,
    required this.buildNumber,
    required this.isSkipped,
    required this.timestamp,
  });
}
