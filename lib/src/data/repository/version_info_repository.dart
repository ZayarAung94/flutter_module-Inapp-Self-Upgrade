import 'package:inapp_self_upgrade/src/data/provider/version_info_remote.dart';
import 'package:inapp_self_upgrade/src/data/services/apk_install_service.dart';
import 'package:inapp_self_upgrade/src/domain/repository/version_info_repository.dart';

class VersionInfoRepoInpl implements VersionInfoRepository {
  final VersionInfoRemoteSource _remoteSource;
  final ApkInstallService _installService;
  VersionInfoRepoInpl({
    VersionInfoRemoteSource? remoteSource,
    ApkInstallService? installService,
  }) : _remoteSource = remoteSource ?? VersionInfoRemoteSource(),
       _installService = installService ?? ApkInstallService();

  @override
  Future<String> downloadApk({
    required String url,
    required String version,
    required Function(double) onProgress,
  }) async {
    return _remoteSource.downloadApk(url, version, onProgress);
  }

  @override
  Future<void> installApk(String filePath) async {
    return _installService.installApk(filePath);
  }
}
