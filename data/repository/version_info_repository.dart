import 'package:taximeter/modules/inapp_self_upgrade/data/provider/version_info_local.dart';
import 'package:taximeter/modules/inapp_self_upgrade/data/provider/version_info_remote.dart';
import 'package:taximeter/modules/inapp_self_upgrade/data/services/apk_install_service.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/entity/version_info_entity.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/entity/version_local_log.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/repository/version_info_repository.dart';

class VersionInfoRepoInpl implements VersionInfoRepository {
  final VersionInfoRemoteSource _remoteSource;
  final VersionInfoLocalSource _localSource;
  final ApkInstallService _installService;
  VersionInfoRepoInpl({
    VersionInfoRemoteSource? remoteSource,
    VersionInfoLocalSource? localSource,
    ApkInstallService? installService,
  }) : _remoteSource = remoteSource ?? VersionInfoRemoteSource(),
       _localSource = localSource ?? VersionInfoLocalSource(),
       _installService = installService ?? ApkInstallService();

  @override
  Future<VersionInfoEntity?> getVersionInfo() async {
    return _remoteSource.get();
  }

  @override
  Future<VersionLocalLog?> getVersionLocalLog() async {
    return _localSource.getVersionLocalLog();
  }

  @override
  Future<void> saveVersionLocalLog(VersionLocalLog log) async {
    return _localSource.saveVersionLocalLog(log);
  }

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
