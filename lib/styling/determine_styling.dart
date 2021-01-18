import 'package:flutter/material.dart';
import 'package:lets_go_soundboard/styling/my_flutter_app_icons.dart';

IconData determineCustomIcon(String text) {

  switch (text) {
    case "LET'S F*****G GO":
      return CustomIcons.letsfuckinggo;
    case "what's gucci my n":
      return CustomIcons.cat;
    default:
      return Icons.audiotrack;
  }

}

Color determineSoundButtonColor(String text, bool darker) {
  Color color;
  switch (text) {
    case "explicitloud":
      color = Colors.red[600];
      break;
    case "explicit":
      color = Colors.red[300];
      break;
    case "loud":
      color = Colors.yellow[300];
      break;
    default:
      color = Colors.blue[100];
      break;
  }

  if (darker)
    color = color
        .withRed(color.red - 50)
        .withBlue(color.blue - 50)
        .withGreen(color.green - 50);

  return color;
}
