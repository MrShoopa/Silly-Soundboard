import 'package:flutter/material.dart';

import 'package:lets_go_soundboard/pages/about_page.dart';
import 'package:lets_go_soundboard/styling/app_theme.dart';

Widget aboutAppButtonCreation(BuildContext context) {
  return ButtonTheme(
      height: 100.0,
      layoutBehavior: ButtonBarLayoutBehavior.padded,
      minWidth: 400,
      buttonColor: stylePrimaryButtonColor(),
      child: RaisedButton.icon(
          icon: Icon(Icons.info_outline, size: 36),
          label: (new Text("About this App",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0))),
          onPressed: () {
            navigateToInfoPage(context);
          }));
}

navigateToInfoPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AboutAppRoute()),
  );
}
