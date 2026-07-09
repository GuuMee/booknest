// lib/core/di/injection.dart

final dir = await getApplicationDocumentsDirectory();
final downloadsBox = await Hive.openBox('downloads');

sl.registerLazySingleton<DownloadService>(
  () => DownloadService(
    dio: sl<Dio>(),
    downloadsBox: downloadsBox,
  ),
);