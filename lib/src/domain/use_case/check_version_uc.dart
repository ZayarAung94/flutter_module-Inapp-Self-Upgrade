import 'package:inapp_self_upgrade/inapp_self_upgrade.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CheckVersionUseCase {
  Future<VersionInfo?> call(VersionInfo versionInfo) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (versionInfo.buildNumber > int.parse(packageInfo.buildNumber)) {
      return versionInfo;
    } else {
      return null;
    }
  }
}
