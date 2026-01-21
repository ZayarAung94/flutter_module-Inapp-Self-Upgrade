import 'package:taximeter/modules/inapp_self_upgrade/domain/entity/version_info_entity.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/repository/version_info_repository.dart';

class CheckVersionUseCase {
  final VersionInfoRepository _repo;
  CheckVersionUseCase(this._repo);

  Future<VersionInfoEntity?> call(int buildNumber) async {
    VersionInfoEntity? versionInfo = await _repo.getVersionInfo();

    if (versionInfo != null) {
      if (versionInfo.buildNumber > buildNumber) {
        return versionInfo;
      } else {
        return null;
      }
    }

    return null;
  }
}
