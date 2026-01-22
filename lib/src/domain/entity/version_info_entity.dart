class VersionInfo {
  final String version;
  final int buildNumber;
  final String downloadUrl;
  final bool forceUpdate;
  final String releaseNotes;

  VersionInfo({
    required this.version,
    required this.buildNumber,
    required this.downloadUrl,
    required this.forceUpdate,
    required this.releaseNotes,
  });
}
