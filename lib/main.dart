/*
  Written by Joe V. (joexvillegas@gmail.com)
  First Commit on January 14th, 2021
*/

library my_prj.main;

import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lets_go_soundboard/styling/app_theme.dart';

import 'components/main_soundboard_view.dart';
import 'components/redirect_button.dart';
import 'components/sound_button.dart';
import 'styling/stylized_texts.dart';

String soundlistReference = "references/soundlist.json";
dynamic directories;
dynamic _soundList;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoopa Soundboard',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: MyHomePage(title: 'Shoopa Soundboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioPlayer _audioPlayer;

  @override
  void initState() {
    // Created for Soundboard audio driver
    _audioPlayer = AudioPlayer();
    // Gathering sound list metadata
    loadSoundReference();

    super.initState();
  }

  Future<void> loadSoundReference() async {
    var soundListString = await rootBundle.loadString(soundlistReference);
    _soundList = jsonDecode(soundListString);
    directories = _soundList['directories'];
    _soundList = _soundList['sounds'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if (_soundList == null) {
      return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisA---lignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 16.0), child: welcomeText),
                Row(children: [
                  new CircularProgressIndicator(),
                  Text("Loading...",
                      style: Theme.of(context).textTheme.bodyText1)
                ])
              ],
            ),
          ));
    } else {
      //* Sources Generated case (Where the resulting view generates)
      List<Widget> generatedChildren = [];
      appendWidget(dynamic songObject) {
        Widget butt = soundButtonCreation(_audioPlayer, songObject);
        generatedChildren.add(butt);
      }

      _soundList.forEach(appendWidget);

      List<Widget> resultingView = soundboardViewGenerator(generatedChildren);

      return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: resultingView),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => navigateToInfoPage(context),
            tooltip: 'App Info and Guide',
            child: const Icon(Icons.info),
            foregroundColor: stylePrimaryTextColor(),
            backgroundColor: stylePrimaryButtonColor()
          ));
    }
  }
}
