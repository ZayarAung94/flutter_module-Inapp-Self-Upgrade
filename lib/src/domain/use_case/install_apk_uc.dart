import 'dart:io';

import 'package:inapp_self_upgrade/src/data/services/apk_install_service.dart';

class InstallApkUseCase {
  final ApkInstallService _installService;
  InstallApkUseCase({ApkInstallService? installService})
    : _installService = installService ?? ApkInstallService();

  Future<void> call(String apkFilePath) async {
    final file = File(apkFilePath);
    if (await file.exists()) {
      // Simulate installation process
      try {
        await _installService.installApk(apkFilePath);
      } catch (e) {
        rethrow;
      }
    } else {
      throw ('APK file does not exist at path: $apkFilePath');
    }
  }
}
