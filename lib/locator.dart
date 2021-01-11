import 'package:fedanoo/services/dialog_service.dart';
import 'package:fedanoo/services/navigationService.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());

// getIt.registerLazySingleton<Authentication>(() =>Authentication());
// getIt.registerLazySingleton<Authentication>(() =>Authentication());
}
