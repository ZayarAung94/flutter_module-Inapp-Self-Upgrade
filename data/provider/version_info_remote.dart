import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taximeter/modules/inapp_self_upgrade/data/model/app_version_model.dart';
import 'package:taximeter/modules/inapp_self_upgrade/domain/entity/version_info_entity.dart';

class VersionInfoRemoteSource {
  final Dio _dio = Dio();

  final CollectionReference _coll = FirebaseFirestore.instance.collection('app_data');

  Future<VersionInfoEntity?> get() async {
    try {
      DocumentSnapshot doc = await _coll.doc('app_version').get();
      if (doc.exists) {
        final model = AppVersion.fromJson(doc.data() as Map<String, dynamic>);

        return model.toEntity();
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> downloadApk(String url, String version, Function(double) onProgress) async {
    try {
      final dir = await getExternalStorageDirectory();
      final savePath = '${dir?.path}/$version.apk';

      final file = File(savePath);
      if (await file.exists()) {
        onProgress(1.0);
        return savePath;
      }

      if (await dir?.exists() ?? false) {
        final List<FileSystemEntity> files = dir!.listSync();
        for (var file in files) {
          if (file is File && file.path.endsWith('.apk')) {
            await file.delete();
          }
        }
      }

      await _dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            onProgress(received / total);
          }
        },
      );
      return savePath;
    } catch (e) {
      rethrow;
    }
  }
}
