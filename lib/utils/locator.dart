import 'package:get_it/get_it.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/services/hive_database_service.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/ui/article/view_models/article_download_view_model.dart';
import 'package:jals/ui/home/components/view_models/daily_read_view_model.dart';
import 'package:jals/services/video_service.dart';
import 'package:jals/ui/video/view_models/video_all_view_model.dart';
import 'package:jals/ui/video/view_models/video_downloads_view_model.dart';
import 'package:jals/ui/video/view_models/video_player_view_model.dart';
import 'package:jals/ui/video/view_models/video_watch_late_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => DailyReadViewModel());
  locator.registerLazySingleton(() => VideoService());
  locator.registerLazySingleton(() => HiveDatabaseService());
  locator.registerLazySingleton(() => ArticleDownloadViewModel());

// getIt.registerLazySingleton<Authentication>(() =>Authentication());
// getIt.registerLazySingleton<Authentication>(() =>Authentication());
//! Factory
  locator.registerFactory(() => VideoDownloadViewModel());
  locator.registerFactory(() => VideoAllViewModel());
  locator.registerFactory(() => VideoPlayerViewViewModel());
  locator.registerFactory(() => VideoWatchLaterViewModel());
}
