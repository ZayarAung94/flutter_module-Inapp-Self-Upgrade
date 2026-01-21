import 'package:get/get.dart';
import 'package:taximeter/modules/inapp_self_upgrade/data/services/apk_install_service.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/repository/version_info_repository.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/use_case/check_version_uc.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/use_case/download_apk_uc.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/use_case/install_apk_uc.dart';

class AppVersionsFacade extends GetxService {
  static AppVersionsFacade get to => Get.find();

  final ApkInstallService _installService = Get.put(ApkInstallService());
  final VersionInfoRepository _versionRepo = Get.find<VersionInfoRepository>();

  late final checkVersion = CheckVersionUseCase(_versionRepo);
  late final downloadApk = DownloadApkUseCase(_versionRepo);
  late final installApk = InstallApkUseCase(_installService);
}
