import 'package:inapp_self_upgrade/src/data/repository/version_info_repository.dart';
import 'package:inapp_self_upgrade/src/domain/repository/version_info_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadApkUseCase {
  final VersionInfoRepository _repo;
  DownloadApkUseCase({VersionInfoRepository? repo}) : _repo = repo ?? VersionInfoRepoInpl();

  Future<String?> call({
    required String apkUrl,
    required String version,
    required Function(double) onProgress,
  }) async {
    try {
      var status = await Permission.requestInstallPackages.status;

      if (status.isDenied || status.isPermanentlyDenied) {
        status = await Permission.requestInstallPackages.request();
        throw ();
      }

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
