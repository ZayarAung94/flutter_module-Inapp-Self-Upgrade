abstract class VersionInfoRepository {
  Future<String> downloadApk({
    required String url,
    required String version,
    required Function(double) onProgress,
  });

  Future<void> installApk(String filePath);
}
