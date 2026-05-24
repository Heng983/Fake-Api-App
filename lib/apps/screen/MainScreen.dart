import 'package:demo_apps/apps/screen/home_screen.dart';
import 'package:demo_apps/apps/screen/search_screen.dart';
import 'package:demo_apps/apps/screen/setting_screen.dart';
import 'package:demo_apps/apps/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      navBarStyle: NavBarStyle.style13,
      padding: EdgeInsets.only(top: 8),
      screens: [FirstScreen(), SearchScreen(), SettingScreen()],
      items: [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: "Home",
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: const Color.fromARGB(88, 0, 0, 0),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.search),
          title: "Search",
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: const Color.fromARGB(88, 0, 0, 0),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.settings),
          title: "Settings",
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: const Color.fromARGB(88, 0, 0, 0),
        ),
      ],
    );
  }
}
