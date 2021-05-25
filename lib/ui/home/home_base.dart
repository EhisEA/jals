import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jals/ui/audio/miniPlayer.dart';
import 'package:jals/ui/audio/view_model/audioService.dart';
import 'package:jals/ui/home/home_view.dart';
import 'package:jals/ui/home/library_view.dart';
import 'package:jals/ui/home/settings_view.dart';
import 'package:jals/ui/store/store_view.dart';
import 'package:jals/ui/home/view_models/home_base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:stacked/stacked.dart';
import 'package:rxdart/rxdart.dart';

class HomeBaseView extends StatefulWidget {
  @override
  _HomeBaseViewState createState() => _HomeBaseViewState();
}

class _HomeBaseViewState extends State<HomeBaseView> {
  @override
  final bool green = false;
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<HomeBaseViewModel>.reactive(
        viewModelBuilder: () => HomeBaseViewModel(),
        builder: (context, model, _) {
          return Scaffold(
            body: Stack(
              children: [
                PersistentTabView(
                    backgroundColor: Colors.white,
                    navBarHeight: 50,
                    onItemSelected: (index) => model.changeTab(index),
                    customWidget: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.3),
                        //     offset: Offset(0, -10),
                        //     blurRadius: 12,
                        //     spreadRadius: -2,
                        //   ),
                        // ],
                        color: Colors.white,
                      ),
                      height: 70,
                      width: double.infinity,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNavIcons(
                                model, 0, "Home", "assets/svgs/holy_bible.svg"),
                            _buildNavIcons(
                                model, 1, "Library", "assets/svgs/library.svg"),
                            _buildNavIcons(
                                model, 2, "Shop", "assets/svgs/shop.svg"),
                            _buildNavIcons(model, 3, "Settings",
                                "assets/svgs/settings.svg"),
                          ]),
                    ),
                    // neumorphicProperties: NeumorphicProperties(),
                    controller: model.controller,
                    screens: _buildScreens(),
                    items: _navBarsItems(),
                    confineInSafeArea: true,
                    // backgroundColor: kScaffoldColor,
                    handleAndroidBackButtonPress: true,
                    resizeToAvoidBottomInset:
                        true, // This needs to be true if you want to move up the screen when keyboard appears.
                    stateManagement: true,
                    hideNavigationBarWhenKeyboardShows:
                        true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
                    decoration: NavBarDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // colorBehindNavBar: kScaffoldColor,
                    ),
                    popAllScreensOnTapOfSelectedTab: true,
                    itemAnimationProperties: ItemAnimationProperties(
                      // Navigation Bar's items animation properties.
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease,
                    ),
                    screenTransitionAnimation: ScreenTransitionAnimation(
                      // Screen transition animation on change of selected tab.
                      animateTabTransition: true,
                      curve: Curves.ease,
                      duration: Duration(milliseconds: 200),
                    ),
                    navBarStyle: NavBarStyle
                        .custom // Choose the nav bar style with this property.
                    ),
                Positioned(
                  bottom: 70,
                  child: AudioServiceWidget(child: MiniPlayerWidget()),
                )
              ],
            ),
          );
        });
  }

  List<Widget> _buildScreens() {
    return [
      HomeView(),
      LibraryView(),
      StoreView(),
      SettingsView(),
    ];
  }

  Widget _buildNavIcons(
    HomeBaseViewModel model,
    int index,
    String title,
    String svgPath,
  ) {
    bool selected = model.controller.index == index;
    return InkWell(
      onTap: () => model.changeTab(index),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                boxShadow: [
                  BoxShadow(
                      color: selected ? kPrimaryColor : Colors.transparent,
                      blurRadius: 2)
                ],
                color: selected ? Colors.blue : Colors.white,
              ),
              // shadowColor: kPrimaryColor,
              // elevation:
              //     model.controller.index == 0 ? 4 : 0,
              child: AnimatedPadding(
                duration: Duration(seconds: 1),
                padding: EdgeInsets.all(selected ? 5.0 : 0),
                child: SvgPicture.asset(
                  svgPath,
                  key: Key("2"),
                  height: 25,
                  color: selected ? Colors.white : Colors.grey.shade300,
                ),
              ),
            ),
            Spacer(),
            Text(
              title,
              style: TextStyle(
                color: selected ? kPrimaryColor : Colors.grey.shade400,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.ac_unit),
        title: ("Home"),
        activeColor: kPrimaryColor,
        inactiveColor: Colors.grey.shade600,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.ac_unit),
        title: ("Tickets"),
        activeColor: kPrimaryColor,
        inactiveColor: Colors.grey.shade600,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.ac_unit),
        title: ("Tickets"),
        activeColor: kPrimaryColor,
        inactiveColor: Colors.grey.shade600,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.ac_unit),
        title: ("Wallet"),
        activeColor: kPrimaryColor,
        inactiveColor: Colors.grey.shade600,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.ac_unit),
        title: ("Chat"),
        activeColor: kPrimaryColor,
        inactiveColor: Colors.grey.shade600,
      ),
    ];
  }
}
