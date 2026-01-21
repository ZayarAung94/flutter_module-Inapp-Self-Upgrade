import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taximeter/core/constant/app_versions.dart';
import 'package:taximeter/core/utils/app_log.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/entity/version_info_entity.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/facades/app_versions_facade.dart';
import 'package:taximeter/ui/widgets/app_message.dart';

class UpdateScreenController extends GetxController {
  final versionFacade = Get.put(AppVersionsFacade());

  RxBool isLoading = false.obs;
  RxBool isDownloading = false.obs;
  RxDouble downloadProgress = 0.0.obs;
  RxnString finlePath = RxnString();

  final Rxn<VersionInfoEntity?> currentVersion = Rxn<VersionInfoEntity?>();

  @override
  void onInit() {
    super.onInit();
    _checkVersion();
  }

  void _checkVersion() async {
    isLoading.value = true;
    try {
      currentVersion.value = await versionFacade.checkVersion.call(AppVersions.buildNumber);
      await Future.delayed(Duration(milliseconds: 300));
    } catch (e) {
      AppLog.error(e.toString());
      AppMessage.error("Failed to check for updates. Please try again later.");
    } finally {
      isLoading.value = false;
    }
  }

  void startDownload() async {
    var status = await Permission.requestInstallPackages.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.requestInstallPackages.request();
      if (!status.isGranted) {
        return;
      }
    }

    try {
      isDownloading.value = true;
      final result = await versionFacade.downloadApk.call(
        apkUrl: currentVersion.value!.downloadUrl,
        version: currentVersion.value!.buildNumber.toString(),
        onProgress: (progress) {
          downloadProgress.value = progress;
        },
      );

      AppLog.info(result.toString());
      finlePath.value = result;
    } catch (e) {
      AppMessage.error(e.toString());
    } finally {
      isDownloading.value = false;
    }
  }

  String get version => currentVersion.value?.version ?? AppVersions.version;
  int get buildNumber => currentVersion.value?.buildNumber ?? AppVersions.buildNumber;
  String get releaseNotes => currentVersion.value?.releaseNotes ?? "";
  bool get isForceUpdate => currentVersion.value?.forceUpdate ?? false;
}
