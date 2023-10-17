import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_app/main.dart';


class SettingPage extends StatefulWidget {

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode"),
                ValueListenableBuilder<ThemeMode>(
                  valueListenable: MyApp.themeNotifier,
                  builder: (_, ThemeMode currentMode, __) {
                    return Switch(
                      value: currentMode == ThemeMode.dark,
                      onChanged: (value) async {
                        MyApp.toggleDarkMode(); // Toggle tema
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isDarkMode', MyApp.themeNotifier.value == ThemeMode.dark);
                      },
                      activeTrackColor: Colors.blue[300],
                      activeColor: Colors.blue[700],
                      inactiveTrackColor: Colors.yellow[300],
                      inactiveThumbColor: Colors.yellow,
                      activeThumbImage: AssetImage('images/icons/ic_moon.webp'),
                      inactiveThumbImage: AssetImage('images/icons/ic_sun.webp'),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

