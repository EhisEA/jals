import 'dart:async';

import 'package:audio_service/audio_service.dart';

/// A store of consumable items.
///
/// This is a development prototype tha stores consumables in the shared
/// preferences. Do not use this in real world apps.
// class ConsumableStore {
//   static const String _kPrefKey = 'consumables';
//   static Future<void> _writes = Future.value();

//   /// Adds a consumable with ID `id` to the store.
//   ///
//   /// The consumable is only added after the returned Future is complete.
// static Future<void> save(String id) {
//   _writes = _writes.then((void _) => _doSave(id));
//   return _writes;
// }

//   /// Consumes a consumable with ID `id` from the store.
//   ///
//   /// The consumable was only consumed after the returned Future is complete.
//   static Future<void> consume(String id) {
//     _writes = _writes.then((void _) => _doConsume(id));
//     return _writes;
//   }

//   /// Returns the list of consumables from the store.
//   static Future<List<String>> load() async {
//     return (await SharedPreferences.getInstance()).getStringList(_kPrefKey) ??
//         [];
//   }

//   static Future<void> _doSave(String id) async {
//     List<String> cached = await load();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     cached.add(id);
//     await prefs.setStringList(_kPrefKey, cached);
//   }

//   static Future<void> _doConsume(String id) async {
//     List<String> cached = await load();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     cached.remove(id);
//     await prefs.setStringList(_kPrefKey, cached);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:jals/services/hive_database_service.dart';
import 'package:jals/ui/audio/view_model/demo.dart';
import 'package:jals/ui/authentication/splashscreen_view.dart';
import 'package:jals/utils/theme.dart';
import 'package:just_audio/just_audio.dart';
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
  //initilising InAppPurchaseConnection for andriod
  //todo check ios reaction
  InAppPurchaseConnection.enablePendingPurchases();
  return runApp(
    //DevicePreview(
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
      title: 'JALS',
      builder: (context, child) {
        var dialogService = locator<DialogService>();
        // return DevicePreview.appBuilder(
        //     context,
        //     Navigator(
        //       key: dialogService.dialogNavigationKey,
        //       onGenerateRoute: (settings) => MaterialPageRoute(
        //           builder: (context) => DialogManager(child: child)),
        //     ));

        /// wraping all widgets inside Navigator and diaglog
        return Navigator(
          key: dialogService.dialogNavigationKey,
          onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
            Future.wait([
              // preloading SVGs
              loadSvg(context, "assets/svgs/d1.svg"),
              loadSvg(context, "assets/svgs/n1.svg"),
              loadSvg(context, "assets/svgs/empty.svg"),
              // loadSvg(context, "svg_2.svg"),
            ]);
            return DialogManager(child: child);
          }),
        );
      },
      theme: MyTheme().themeData,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: AudioServiceWidget(child: SplashScreenView()),
      // home: SplashScreenView(),
    );

    // home: VideoPlayer());
  }

  Future<SvgPicture> loadSvg(BuildContext context, String path) async {
    var picture = SvgPicture.asset(path);
    await precachePicture(picture.pictureProvider, context);
    return picture;
  }

  // e() {
  //   AudioService.start(
  //     backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
  //     androidNotificationChannelName: 'Jasl',
  //     // Enable this if you want the Android service to exit the foreground state on pause.
  //     androidStopForegroundOnPause: true,
  //     androidNotificationColor: 0xFF2196f3,
  //     androidNotificationIcon: 'mipmap/launcher_icon',
  //     androidEnableQueue: true,
  //   );
  // }

  // void _audioPlayerTaskEntrypoint() async {
  //   AudioServiceBackground.run(() => AudioPlayerTask());
  // }
}
