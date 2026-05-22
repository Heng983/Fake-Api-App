import 'package:demo_apps/apps/controller/grid_style_controller.dart';
import 'package:demo_apps/apps/controller/theme_controlle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final images =
        "https://i.pinimg.com/736x/19/ad/7e/19ad7edff92d85bf46b28cebd129060b.jpg";
    bool _isDarkMode = context.watch<ThemeController>().isDarkMode;
    bool _gridStyle = context.watch<GridStyleController>().gridStyle;

    return Scaffold(
      appBar: AppBar(title: Text("Setting Screen"), centerTitle: true),
      body: ListView(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(images), radius: 140),
          Divider(thickness: 2, color: Colors.grey),
          Card(
            child: ListTile(
              leading: Icon(Icons.settings_applications, size: 14),
              title: Text("Switched to ${_isDarkMode ? "Dark" : "Light"} Mode"),
              trailing: Icon(
                _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                size: 12,
              ),
              onTap: () {
                context.read<ThemeController>().toggleTheme();
              },
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.grid_view_outlined, size: 14),
              title: Text("Switched to ${_gridStyle ? "Grid" : "List"} View"),
              trailing: Icon(
                _gridStyle ? Icons.grid_view : Icons.list,
                size: 12,
              ),
              onTap: () {
                context.read<GridStyleController>().toggleGridStyle();
              },
            ),
          ),
        ],
      ),
    );
  }
}
