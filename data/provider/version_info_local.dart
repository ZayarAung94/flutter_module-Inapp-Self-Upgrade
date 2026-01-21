import 'package:get_storage/get_storage.dart';
import 'package:taximeter/modules/inapp_self_upgrade/data/model/version_local_log_model.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/entity/version_local_log.dart';

class VersionInfoLocalSource {
  final GetStorage _storage = GetStorage();
  final String _key = 'version_local_log';

  Future<VersionLocalLog?> getVersionLocalLog() async {
    final rawData = _storage.read(_key);
    if (rawData != null) {
      final model = VersionLocalLogModel.fromJson(rawData as Map<String, dynamic>);
      return model.toEntity();
    }
    return null;
  }

  Future<void> saveVersionLocalLog(VersionLocalLog log) async {
    final model = VersionLocalLogModel.fromEntity(log);
    await _storage.write(_key, model.toJson());
  }
}
