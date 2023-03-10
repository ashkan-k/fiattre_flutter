import 'package:fiatre_app/config/my_flutter_app_icons.dart';
import 'package:fiatre_app/pages/components/my_app_bar.dart';
import 'package:fiatre_app/pages/home_page.dart';
import 'package:fiatre_app/pages/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late PersistentTabController _controller;

  List<Widget> _buildScreens() {
    return [
      TestPage(),
      TestPage(),
      TestPage(),
      TestPage(),
      HomePage(),
    ];
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 4);
  }

  @override
  Widget build(BuildContext context) {

    Color? backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    Color? activeTabColor = Theme.of(context).iconTheme.color;

    return PersistentTabView(
      onItemSelected: (value) {},
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems((activeTabColor)!),
      popAllScreensOnTapAnyTabs: true,
      confineInSafeArea: true,
      backgroundColor: (backgroundColor)!, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(12),
        colorBehindNavBar: (backgroundColor)!,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems(activeTabColor) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("????????"),
        activeColorPrimary: (activeTabColor)!,
        inactiveColorPrimary: Theme.of(context).bottomAppBarColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add_business_outlined),
        title: ("???????? ????????"),
        activeColorPrimary: (activeTabColor)!,
        inactiveColorPrimary: Theme.of(context).bottomAppBarColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.gamecontroller),
        title: ("???????? ?? ????????????"),
        activeColorPrimary: (activeTabColor)!,
        inactiveColorPrimary: Theme.of(context).bottomAppBarColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.search),
        title: ("??????????"),
        activeColorPrimary: (activeTabColor)!,
        inactiveColorPrimary: Theme.of(context).bottomAppBarColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("???????? ????"),
        activeColorPrimary: (activeTabColor)!,
        inactiveColorPrimary: Theme.of(context).bottomAppBarColor,
      ),
    ].reversed.toList();
  }
}
