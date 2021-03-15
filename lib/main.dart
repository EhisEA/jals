import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jals/services/hive_database_service.dart';
import 'package:jals/ui/authentication/splashscreen_view.dart';
import 'package:jals/ui/home/home_base.dart';
import 'package:jals/utils/theme.dart';
import 'utils/locator.dart';
import 'managers/dialog_manager.dart';
import 'utils/router.dart';
import 'services/dialog_service.dart';
import 'services/navigationService.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(); //*====registering get_it
  //======= registering all type adpaters and
  //======= opening all local database for quick
  //======= access

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  locator<HiveDatabaseService>().openBoxes();
  return runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => MyApp(),
    // )
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context, child) {
        var dialogService = locator<DialogService>();
        // return DevicePreview.appBuilder(context, child);

        /// wraping all widgets inside Navigator and diaglog
        return Navigator(
          key: dialogService.dialogNavigationKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => DialogManager(child: child)),
        );
      },
      theme: MyTheme().themeData,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: HomeBaseView(),
    );

    // home: VideoPlayer());
  }
}
