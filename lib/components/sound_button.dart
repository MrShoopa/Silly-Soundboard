import 'dart:ui';

import '../main.dart' as globals;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:lets_go_soundboard/styling/determine_styling.dart';

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
                        textAlign: TextAlign.center))),
          ),
        ),
        onPressed: () {
          audioPlayer
              .play(globals.directories['soundfile'] + songObject['filename']);
        },
      ));
}
