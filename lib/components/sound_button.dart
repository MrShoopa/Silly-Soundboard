import '../main.dart' as globals;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:lets_go_soundboard/styling/determine_styling.dart';

Widget soundButtonCreation(AudioPlayer audioPlayer, dynamic songObject) {
  IconData icon =
      determineCustomIcon(songObject['title']);
  bool darkMode =
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark
          ? true
          : false;

  return ButtonTheme(
      height: 100.0,
      buttonColor: determineSoundButtonColor(songObject['class'], darkMode),
      child: RaisedButton.icon(
          icon: Icon(icon, size: 36),

          padding: EdgeInsets.only(top: 20, bottom: 15),
          label: Text(songObject['title'], style: TextStyle()),
          onPressed: () {
            audioPlayer
                .play(globals.directories['soundfile'] + songObject['filename']);
          }));
}
