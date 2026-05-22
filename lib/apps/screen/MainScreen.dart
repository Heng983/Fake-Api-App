import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:demo_apps/apps/screen/home_screen.dart';
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
      screens: [
        FirstScreen(),
        Container(color: Colors.amberAccent),
        Container(color: Colors.blueGrey),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home, color: Colors.black),
          title: "Home",
          activeColorPrimary: Colors.blueGrey,
          inactiveColorPrimary: const Color.fromARGB(88, 0, 0, 0),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.search),
          title: "Search",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: const Color.fromARGB(88, 0, 0, 0),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.settings),
          title: "Settings",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: const Color.fromARGB(88, 0, 0, 0),
        ),
      ],
    );
  }
}
