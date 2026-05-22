import 'package:demo_apps/apps/controller/grid_style_controller.dart';
import 'package:demo_apps/apps/controller/theme_controlle.dart';
import 'package:demo_apps/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget appProvider() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeController()),
      ChangeNotifierProvider(create: (_) => GridStyleController()),
    ],
    child: AppLogic(),
  );
}
