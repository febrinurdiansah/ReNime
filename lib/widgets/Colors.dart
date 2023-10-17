import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    color:  Color.fromRGBO(10, 10, 10, 1),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 16, 61, 101),
  ),
  colorScheme: ColorScheme.dark(
    background: Color.fromRGBO(33, 33, 33, 1),
    primary: Colors.white
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Color.fromRGBO(0, 94, 189, 1)
  ),
  cardColor: Color.fromRGBO(6, 119, 231, 1),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 1,color: Color.fromRGBO(85, 179, 207, 1)),
      borderRadius: BorderRadius.all(Radius.circular(20))
    )
  )
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    color:  Colors.white,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Color.fromRGBO(97, 224, 255, 1),
  ),
  colorScheme: ColorScheme.light(
    background: Color.fromRGBO(238, 238, 238, 1),
    primary: Colors.black
  ),
  chipTheme: ChipThemeData(
    brightness: Brightness.light,
    backgroundColor: Color.fromRGBO(97, 224, 255, 1),
  ),
  cardColor: Color.fromRGBO(97, 224, 255, 1),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 1,color: Color.fromRGBO(85, 179, 207, 1)),
      borderRadius: BorderRadius.all(Radius.circular(20))
    )
  )
);