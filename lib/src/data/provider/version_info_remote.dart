import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class VersionInfoRemoteSource {
  final Dio _dio = Dio();

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
