// // import 'package:flutter/material.dart';
// // import 'package:pip_view/pip_view.dart';

// // class ExampleApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: HomeScreen(),
// //     );
// //   }
// // }

// // class HomeScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return PIPView(
// //       builder: (context, isFloating) {
// //         return Scaffold(
// //           resizeToAvoidBottomInset: !isFloating,
// //           body: SafeArea(
// //             child: Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.stretch,
// //                 children: <Widget>[
// //                   Text('This page will float!'),
// //                   MaterialButton(
// //                     color: Theme.of(context).primaryColor,
// //                     child: Text('Start floating!'),
// //                     onPressed: () {
// //                       PIPView.of(context).presentBelow(BackgroundScreen());
// //                     },
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // class BackgroundScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: <Widget>[
// //               Text('This is the background page!'),
// //               Text('If you tap on the floating screen, it stops floating.'),
// //               Text('Navigation works as expected.'),
// //               MaterialButton(
// //                 color: Theme.of(context).primaryColor,
// //                 child: Text('Push to navigation'),
// //                 onPressed: () {
// //                   Navigator.of(context).push(
// //                     MaterialPageRoute(
// //                       builder: (_) => NavigatedScreen(),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class NavigatedScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Navigated Screen'),
// //       ),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: <Widget>[
// //               Text('This is the page you navigated to.'),
// //               Text('See how it stays below the floating page?'),
// //               Text('Just amazing!'),
// //               Spacer(),
// //               Text('It also avoids keyboard!'),
// //               TextField(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';
// import 'package:jals/services/navigationService.dart';
// import 'package:jals/ui/authentication/login_view.dart';
// import 'package:jals/utils/locator.dart';
// // import 'package:miniplayer/miniplayer.dart';

// import '../route_paths.dart';

// final ValueNotifier<double> playerExpandProgress =
//     ValueNotifier(playerMinHeight);

// // final MiniplayerController controller = MiniplayerController();

// class DetailedPlayer extends StatelessWidget {
//   final AudioObject audioObject;

//   const DetailedPlayer({Key key, @required this.audioObject}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Miniplayer(
//       valueNotifier: playerExpandProgress,
//       minHeight: playerMinHeight,
//       maxHeight: MediaQuery.of(context).size.height,
//       controller: controller,
//       elevation: 4,
//       onDismissed: () => currentlyPlaying.value = null,
//       curve: Curves.easeOut,
//       builder: (height, percentage) {
//         final bool miniplayer = percentage < miniplayerPercentageDeclaration;
//         final double width = MediaQuery.of(context).size.width;
//         final maxImgSize = width * 0.4;

//         final img = Image.network(audioObject.img);
//         final text = Text(audioObject.title);
//         const buttonPlay = IconButton(
//           icon: Icon(Icons.pause),
//           onPressed: onTap,
//         );
//         final progressIndicator = LinearProgressIndicator(value: 0.3);

//         //Declare additional widgets (eg. SkipButton) and variables
//         if (!miniplayer) {
//           var percentageExpandedPlayer = percentageFromValueInRange(
//               min: MediaQuery.of(context).size.height *
//                       miniplayerPercentageDeclaration +
//                   playerMinHeight,
//               max: MediaQuery.of(context).size.height,
//               value: height);
//           if (percentageExpandedPlayer < 0) percentageExpandedPlayer = 0;
//           final paddingVertical = valueFromPercentageInRange(
//               min: 0, max: 10, percentage: percentageExpandedPlayer);
//           final double heightWithoutPadding = height - paddingVertical * 2;
//           final double imageSize = heightWithoutPadding > maxImgSize
//               ? maxImgSize
//               : heightWithoutPadding;
//           final paddingLeft = valueFromPercentageInRange(
//                 min: 0,
//                 max: width - imageSize,
//                 percentage: percentageExpandedPlayer,
//               ) /
//               2;

//           const buttonSkipForward = IconButton(
//             icon: Icon(Icons.forward_30),
//             iconSize: 33,
//             onPressed: onTap,
//           );
//           const buttonSkipBackwards = IconButton(
//             icon: Icon(Icons.replay_10),
//             iconSize: 33,
//             onPressed: onTap,
//           );
//           const buttonPlayExpanded = IconButton(
//             icon: Icon(Icons.pause_circle_filled),
//             iconSize: 50,
//             onPressed: onTap,
//           );

//           return Column(
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                       left: paddingLeft,
//                       top: paddingVertical,
//                       bottom: paddingVertical),
//                   child: SizedBox(
//                     height: imageSize,
//                     child: img,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 33),
//                   child: Opacity(
//                     opacity: percentageExpandedPlayer,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         text,
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             buttonSkipBackwards,
//                             buttonPlayExpanded,
//                             buttonSkipForward
//                           ],
//                         ),
//                         progressIndicator,
//                         Container(),
//                         Container(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }

//         //Miniplayer
//         final percentageMiniplayer = percentageFromValueInRange(
//             min: playerMinHeight,
//             max: MediaQuery.of(context).size.height *
//                     miniplayerPercentageDeclaration +
//                 playerMinHeight,
//             value: height);

//         final elementOpacity = 1 - 1 * percentageMiniplayer;
//         final progressIndicatorHeight = 4 - 4 * percentageMiniplayer;

//         return Column(
//           children: [
//             Expanded(
//               child: Row(
//                 children: [
//                   ConstrainedBox(
//                     constraints: BoxConstraints(maxHeight: maxImgSize),
//                     child: img,
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Opacity(
//                         opacity: elementOpacity,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(audioObject.title,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyText2
//                                     .copyWith(fontSize: 16)),
//                             Text(
//                               audioObject.subtitle,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText2
//                                   .copyWith(
//                                       color: Colors.black.withOpacity(0.55)),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                       icon: Icon(Icons.fullscreen),
//                       onPressed: () {
//                         controller.animateToHeight(state: PanelState.MAX);
//                       }),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 3),
//                     child: Opacity(
//                       opacity: elementOpacity,
//                       child: buttonPlay,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: progressIndicatorHeight,
//               child: Opacity(
//                 opacity: elementOpacity,
//                 child: progressIndicator,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// void onTap() {}
// ValueNotifier<AudioObject> currentlyPlaying = ValueNotifier(null);

// const double playerMinHeight = 70;
// const double playerMaxsHeight = 370;
// const miniplayerPercentageDeclaration = 0.2;

// // class MyAppp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Miniplayer Demo',
// //       theme: ThemeData(
// //         primaryColor: Colors.grey[50],
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //       ),
// //       home: MyHomePage(),
// //     );
// //   }
// // }

// class FirstScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Demo: FirstScreen')),
//       body: Container(
//         constraints: BoxConstraints.expand(),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SecondScreen()),
//               ),
//               child: const Text('Open SecondScreen'),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.of(context, rootNavigator: true).push(
//                 MaterialPageRoute(builder: (context) => ThirdScreen()),
//               ),
//               child: const Text('Open ThirdScreen with root Navigator'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Demo: SecondScreen')),
//       body: Center(child: Text('SecondScreen')),
//     );
//   }
// }

// class ThirdScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Demo: ThirdScreen')),
//       body: Center(child: Text('ThirdScreen')),
//     );
//   }
// }

// final _navigatorKey = GlobalKey();

// class MyHomePageee extends StatefulWidget {
//   @override
//   _MyHomePageeeState createState() => _MyHomePageeeState();
// }

// class _MyHomePageeeState extends State<MyHomePageee> {
//   @override
//   Widget build(BuildContext context) {
//     return MiniplayerWillPopScope(
//       onWillPop: () async {
//         final NavigatorState navigator = _navigatorKey.currentState;
//         if (!navigator.canPop()) return true;
//         navigator.pop();

//         return false;
//       },
//       child: Scaffold(
//         body: Stack(
//           children: [

//             Column(
//               children: [
//                 AppBar(title: Text('Miniplayer Demo')),
//                 Expanded(
//                   child: AudioUi(
//                     onTap: (audioObject) =>
//                         currentlyPlaying.value = audioObject,
//                   ),
//                 ),
//               ],
//             ),
//            Navigator(
//               key: _navigatorKey,
//               onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
//                 settings: settings,
//                 builder: (BuildContext context) => FirstScreen(),
//               ),
//             ),
//             ValueListenableBuilder(
//               valueListenable: currentlyPlaying,
//               builder: (BuildContext context, AudioObject audioObject,
//                       Widget child) =>
//                   audioObject != null
//                       ? DetailedPlayer(audioObject: audioObject)
//                       : Container(),
//             ),
//           ],
//         ),
//         bottomNavigationBar: ValueListenableBuilder(
//           valueListenable: playerExpandProgress,
//           builder: (BuildContext context, double height, Widget child) {
//             final value = percentageFromValueInRange(
//                 min: playerMinHeight,
//                 max: MediaQuery.of(context).size.height,
//                 value: height);

//             var opacity = 1 - value;
//             if (opacity < 0) opacity = 0;
//             if (opacity > 1) opacity = 1;

//             return SizedBox(
//               height: kBottomNavigationBarHeight -
//                   kBottomNavigationBarHeight * value,
//               child: Transform.translate(
//                 offset: Offset(0.0, kBottomNavigationBarHeight * value * 0.5),
//                 child: Opacity(opacity: opacity, child: child),
//               ),
//             );
//           },
//           child: BottomNavigationBar(
//             currentIndex: 0,
//             selectedItemColor: Colors.blue,
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
//               BottomNavigationBarItem(
//                   icon: GestureDetector(
//                       onTap: () {
//                         // Navigator.push(context,
//                         //   MaterialPageRoute(builder: (context) => LoginView()));
//                         locator<NavigationService>().navigateTo(LoginViewRoute);
//                       },
//                       child: Icon(Icons.library_books)),
//                   label: 'Library'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AudioObject {
//   final String title, subtitle, img;

//   const AudioObject(this.title, this.subtitle, this.img);
// }

// double valueFromPercentageInRange(
//     {@required final double min, max, percentage}) {
//   return percentage * (max - min) + min;
// }

// double percentageFromValueInRange({@required final double min, max, value}) {
//   return (value - min) / (max - min);
// }

// typedef OnTap(AudioObject audioObject);

// class AudioListTile extends StatelessWidget {
//   final AudioObject audioObject;
//   final Function onTap;

//   const AudioListTile(
//       {Key key, @required this.audioObject, @required this.onTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: ClipRRect(
//         borderRadius: BorderRadius.circular(4),
//         child: Image.network(
//           audioObject.img,
//           width: 52,
//           height: 52,
//           fit: BoxFit.cover,
//         ),
//       ),
//       title: Text(audioObject.title),
//       subtitle: Text(
//         audioObject.subtitle,
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//       ),
//       trailing: IconButton(
//         icon: Icon(Icons.play_arrow_outlined),
//         onPressed: () => onTap(),
//       ),
//     );
//   }
// }

// typedef OnTapp(final AudioObject audioObject);

// const Set<AudioObject> audioExamples = {
//   AudioObject('Salt & Pepper', 'Dope Lemon',
//       'https://m.media-amazon.com/images/I/81UYWMG47EL._SS500_.jpg'),
//   AudioObject('Losing It', 'FISHER',
//       'https://m.media-amazon.com/images/I/9135KRo8Q7L._SS500_.jpg'),
//   AudioObject('American Kids', 'Kenny Chesney',
//       'https://cdn.playbuzz.com/cdn/7ce5041b-f9e8-4058-8886-134d05e33bd7/5c553d94-4aa2-485c-8a3f-9f496e4e4619.jpg'),
//   AudioObject('Wake Me Up', 'Avicii',
//       'https://upload.wikimedia.org/wikipedia/en/d/da/Avicii_Wake_Me_Up_Official_Single_Cover.png'),
//   AudioObject('Missing You', 'Mesto',
//       'https://img.discogs.com/EcqkrmOCbBguE3ns-HrzNmZP4eM=/fit-in/600x600/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-12539198-1537229070-5497.jpeg.jpg'),
//   AudioObject('Drop it dirty', 'Tavengo',
//       'https://images.shazam.com/coverart/t416659652-b1392404277_s400.jpg'),
//   AudioObject('Cigarettes', 'Tash Sultana',
//       'https://m.media-amazon.com/images/I/91vBpel766L._SS500_.jpg'),
//   AudioObject('Ego Death', 'Ty Dolla \$ign, Kanye West, FKA Twigs, Skrillex',
//       'https://static.stereogum.com/uploads/2020/06/Ego-Death-1593566496.jpg'),
// };

// class AudioUi extends StatelessWidget {
//   final OnTapp onTap;

//   const AudioUi({Key key, @required this.onTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(0),
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 10, bottom: 6, top: 15),
//           child: Text('Your Library:'),
//         ),
//         for (AudioObject a in audioExamples)
//           AudioListTile(audioObject: a, onTap: () => onTap(a))
//       ],
//     );
//   }
// }
