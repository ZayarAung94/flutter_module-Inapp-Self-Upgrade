import 'package:inapp_self_upgrade/src/data/repository/version_info_repository.dart';
import 'package:inapp_self_upgrade/src/domain/repository/version_info_repository.dart';

class DownloadApkUseCase {
  final VersionInfoRepository _repo;
  DownloadApkUseCase({VersionInfoRepository? repo}) : _repo = repo ?? VersionInfoRepoInpl();

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
      rethrow;
    }
  }
}
