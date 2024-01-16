import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_frontend/pages/courses_page.dart';
import 'package:jupiter_frontend/pages/settings_page.dart';
import 'package:jupiter_frontend/pages/home_page.dart';
import 'package:jupiter_frontend/pages/theme_page.dart';
import 'package:jupiter_frontend/widgets/callisto_app_bar.dart';
import 'package:jupiter_frontend/widgets/callisto_drawer.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 1);

  // List<Widget> _buildScreens() {
  //       return [
  //         // TODO! this becomes courses page
  //         CoursePage(),
  //         HomePage(),
  //         SettingsPage()
  //       ];
  //   }

  //   List<PersistentBottomNavBarItem> _navBarsItems() {
  //       return [
  //           PersistentBottomNavBarItem(
  //               icon: Icon(CupertinoIcons.doc),
  //               title: ("Courses"),
  //               activeColorPrimary: Theme.of(context).colorScheme.onSecondary,
  //               inactiveColorPrimary: CupertinoColors.systemGrey,
  //           ),
  //           PersistentBottomNavBarItem(
  //               icon: Icon(CupertinoIcons.home),
  //               title: ("Home"),
  //               activeColorPrimary: Theme.of(context).colorScheme.onSecondary,
  //               inactiveColorPrimary: CupertinoColors.systemGrey,
  //           ),
  //           PersistentBottomNavBarItem(
  //               icon: Icon(CupertinoIcons.settings),
  //               title: ("Settings"),
  //               activeColorPrimary: Theme.of(context).colorScheme.onSecondary,
  //               inactiveColorPrimary: CupertinoColors.systemGrey,
  //           ),
  //       ];
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CallistoAppBar(title: "Callisto"),
      drawer: CallistoDrawer(),
      body: HomePage()
    );
    // return PersistentTabView(
    //     context,
    //     controller: _controller,
    //     screens: _buildScreens(),
    //     items: _navBarsItems(),
    //     confineInSafeArea: true,
    //     backgroundColor: Theme.of(context).colorScheme.secondary, // Default is Colors.white.
    //     handleAndroidBackButtonPress: true, // Default is true.
    //     resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
    //     stateManagement: true, // Default is true.
    //     hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
    //     decoration: NavBarDecoration(
    //       borderRadius: BorderRadius.circular(10.0),
    //       colorBehindNavBar: Theme.of(context).colorScheme.background,
    //     ),
    //     popAllScreensOnTapOfSelectedTab: true,
    //     popActionScreens: PopActionScreensType.all,
    //     itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
    //       duration: Duration(milliseconds: 400),
    //       curve: Curves.easeOutSine,
    //     ),
    //     screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
    //       animateTabTransition: true,
    //       curve: Curves.easeOutSine,
    //       duration: Duration(milliseconds: 400),
    //     ),
    //     navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
  }
}