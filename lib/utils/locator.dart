
import 'package:get_it/get_it.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/services/navigationService.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());

// getIt.registerLazySingleton<Authentication>(() =>Authentication());
// getIt.registerLazySingleton<Authentication>(() =>Authentication());
}
