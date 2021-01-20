import 'package:flutter/material.dart';
import 'package:shoopa_soundboard/styling/stylized_texts.dart';

List<Widget> soundboardViewGenerator(List<Widget> generatedChildren) {
  return [
    Padding(padding: EdgeInsets.only(top: 16.0, bottom: 16.0), child: welcomeText),
    Expanded(
      flex: 3,
      child: SizedBox(
        height: 100.0,
        child: new GridView.count(
          shrinkWrap: true,
          childAspectRatio: 3,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: generatedChildren,
        ),
      ),
    ),
  ];
}
