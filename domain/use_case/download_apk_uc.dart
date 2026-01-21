import 'package:taximeter/modules/inapp_self_upgrade/domain/repository/version_info_repository.dart';

class DownloadApkUseCase {
  final VersionInfoRepository _repo;
  DownloadApkUseCase(this._repo);

  Future<String?> call({
    required String apkUrl,
    required String version,
    required Function(double) onProgress,
  }) async {
    try {
      String filePath = await _repo.downloadApk(
        url: apkUrl,
        version: version,
        onProgress: onProgress,
      );
      return filePath;
    } catch (e) {
      return null;
    }
  }
}
