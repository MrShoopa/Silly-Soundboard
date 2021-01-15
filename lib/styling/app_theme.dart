import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.cyan,
    primaryColor: Colors.cyan);

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: darkCyan,
    primaryColor: Colors.cyan[900],
    buttonColor: Colors.cyan[800],
    primaryColorBrightness: Brightness.dark);

const MaterialColor darkCyan = MaterialColor(
  _darkCyanPrimaryValue,
  <int, Color>{
    50: Color(0xFFE0F7FA),
    100: Color(0xFFB2EBF2),
    200: Color(0xFF80DEEA),
    300: Color(0xFF4DD0E1),
    400: Color(0xFF26C6DA),
    500: Color(0xFF26C6DA),
    600: Color(0xFF00ACC1),
    700: Color(0xFF0097A7),
    800: Color(0xFF00838F),
    900: Color(_darkCyanPrimaryValue),
  },
);

const int _darkCyanPrimaryValue = 0xFF006064;

Color stylePrimaryButtonColor() {
  if (darkMode)
    return Colors.cyan[900];
  else
    return Colors.cyan;
}

Color stylePrimaryTextColor() {
  if (darkMode)
    return Colors.white;
  else
    return Colors.black;
}

bool darkMode =
    SchedulerBinding.instance.window.platformBrightness == Brightness.dark
        ? true
        : false;
