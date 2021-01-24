import 'dart:ui';

import '../main.dart' as globals;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:shoopa_soundboard/styling/determine_styling.dart';

import '../styling/app_theme.dart';

Widget soundButtonCreation(AudioPlayer audioPlayer, dynamic songObject) {
  var iconDir = globals.directories['iconfile'] + songObject['icon'];

  AssetImage image = AssetImage(iconDir) != null
      ? AssetImage(iconDir)
      : determineCustomIcon(songObject['title']);

  return ButtonTheme(
      height: 100.0,
      child: MaterialButton(
        elevation: 8.0,
        child: Container(
          decoration: BoxDecoration(
            color: determineSoundButtonColor(
                songObject['class'], globals.darkMode),
            image: DecorationImage(
                image: image,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.20), BlendMode.dstATop),
                fit: BoxFit.cover),
          ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox.expand(
                  child: Center(
                child: Text(songObject['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 00.0),
                            blurRadius: 5.0,
                            color: determineShadowColor(),
                          )
                        ])),
              ))),
        ),
        onPressed: () {
          audioPlayer
              .play(globals.directories['soundfile'] + songObject['filename']);
          //TODO: Shake phone on loud sound playback
        },
      ));
}

Color determineShadowColor() {
  if (!darkMode)
    return Color.fromARGB(255, 0, 0, 0);
  else
    return Color.fromARGB(255, 255, 255, 255);
}
