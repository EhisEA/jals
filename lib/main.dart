import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jals/ui/article_view.dart';
import 'package:jals/ui/home/components/library_view.dart';
import 'package:jals/ui/home/home_view.dart';
import 'package:jals/ui/library/article_library_view.dart';
import 'package:jals/ui/library/audio_library_view.dart';
import 'package:jals/ui/library/video_library_view.dart';
import 'package:jals/ui/playlist_view.dart';

import 'package:jals/utils/theme.dart';

import 'locator.dart';
import 'router.dart';
import 'services/dialog_service.dart';
import 'services/navigationService.dart';

void main() {
  setupLocator(); //*====registaring get_it
  return runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(),
  )
      // MyApp(),
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
          return DevicePreview.appBuilder(context, child);
          // return Navigator(
          //   key: dialogService.dialogNavigationKey,
          //   onGenerateRoute: (settings) => MaterialPageRoute(
          //       builder: (context) => DialogManager(child: child)),
          // );
        },
        theme: MyTheme().themeData,
        onGenerateRoute: AppRouter.generateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
        home: AudioLibrary());

    // home: VideoPlayer());
  }
}
