import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/SearchPage.dart';
import 'screens/BookmarksPage.dart';
import 'screens/Home.dart';
import 'screens/AnimeDetailPage.dart';
import 'widgets/Colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isDarkMode = await getDarkMode();
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child: MyApp(isDarkMode: isDarkMode),
    ),
  );
}


Future<bool> getDarkMode() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isDarkMode') ?? false;
}


class MyApp extends StatefulWidget {
  final bool isDarkMode;
  MyApp({required this.isDarkMode});

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  static void toggleDarkMode() {
    themeNotifier.value =
        themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    MyApp.themeNotifier.value = widget.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: MyApp.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainPage(),
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: currentMode,
        );
      },
    );
  }
}



class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    BookmartPage()
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color _activeColor = theme.brightness == Brightness.dark ? Color.fromARGB(255, 90, 134, 255) : Colors.indigo;
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: selectedIndex,
        showElevation: true,
        backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
        height: 55,
        onItemSelected: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            activeColor: _activeColor,
            inactiveColor: Colors.white,
            icon: Icon(Icons.home), 
            title: Text('Home')
            ),
          FlashyTabBarItem(
            activeColor: _activeColor,
            inactiveColor: Colors.white,
            icon: Icon(Icons.search), 
            title: Text('Search')
            ),
          FlashyTabBarItem(
            activeColor: _activeColor,
            inactiveColor: Colors.white,
            icon: Icon(Icons.bookmarks), 
            title: Text('Bookmarks')
            ),
        ], 
        ),
      );
  }
}
