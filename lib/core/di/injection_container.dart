// lib/core/di/injection_container.dart

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../services/download_service.dart';

Future<void> setupDependencies() async {

  // ── Download Directory ──
  final appDir = await getApplicationDocumentsDirectory();
  final downloadDir = '${appDir.path}/downloads';

  // ── Download Box ──
  final downloadBox = await Hive.openBox<dynamic>(
    'download_box',
  );

  // ── Download Service ──
  sl.registerLazySingleton<DownloadService>(
    () => DownloadService(
      dio: sl<Dio>(),
      downloadDirectory: downloadDir,
      downloadBox: downloadBox,
    ),
  );
}