import 'dart:io';

import 'package:taximeter/core/utils/app_log.dart';
import 'package:taximeter/modules/inapp_self_upgrade/data/services/apk_install_service.dart';

class InstallApkUseCase {
  final ApkInstallService _installService;
  InstallApkUseCase(this._installService);

  Future<void> call(String apkFilePath) async {
    final file = File(apkFilePath);
    if (await file.exists()) {
      // Simulate installation process
      try {
        await _installService.installApk(apkFilePath);
      } catch (e) {
        AppLog.error(e.toString());
        rethrow;
      }
    } else {
      throw ('APK file does not exist at path: $apkFilePath');
    }
  }
}
