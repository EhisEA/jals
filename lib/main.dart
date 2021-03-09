import 'package:flutter/material.dart';
import 'package:jals/ui/audio/audio_library_view.dart';
import 'package:jals/utils/theme.dart';
import 'utils/locator.dart';
import 'managers/dialog_manager.dart';
import 'utils/router.dart';
import 'services/dialog_service.dart';
import 'services/navigationService.dart';

void main() {
  setupLocator(); //*====registaring get_it
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
        return Navigator(
          key: dialogService.dialogNavigationKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => DialogManager(child: child)),
        );
      },
      theme: MyTheme().themeData,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: AudioLibrary(), //SplashScreenView(),
    );

    // home: VideoPlayer());
  }
}
