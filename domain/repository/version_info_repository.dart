import 'package:taximeter/modules/inapp_self_upgrade/domain/entity/version_info_entity.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/entity/version_local_log.dart';

abstract class VersionInfoRepository {
  Future<VersionInfoEntity?> getVersionInfo();

  Future<String> downloadApk({
    required String url,
    required String version,
    required Function(double) onProgress,
  });

  Future<void> installApk(String filePath);

  Future<VersionLocalLog?> getVersionLocalLog();
  Future<void> saveVersionLocalLog(VersionLocalLog log);
}
