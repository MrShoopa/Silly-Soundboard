import 'package:flutter/material.dart';

import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About"),
        ),
        body: Column(children: [
          colorCodeTitle,
          Expanded(
              child: new ListView.builder(
                  itemCount: colorButtonLegendNeo.length,
                  padding: EdgeInsets.all(20),
                  itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.all(2.5),
                      child: Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.grey[900],
                          child: colorButtonLegendNeo[index])))),
          extraInfo,
          emailButton
        ]));
  }
}

//* Components

List<Row> colorButtonLegendNeo = [
  colorCodeLegendTextBar(Colors.red[500], "Loud + EXPLICIT",
      "I'd play these with quiet headphones."),
  colorCodeLegendTextBar(
      Colors.red[200], "Explicit", "I'd play this away from kids."),
  colorCodeLegendTextBar(Colors.yellow[200], "Loud", "RIP headphone users?"),
  colorCodeLegendTextBar(Colors.blue[100], "Normal", "Nothing too crazy."),
];

ListView colorButtonLegendView() {
  return new ListView(
      padding: EdgeInsets.all(20), children: colorButtonLegendNeo);
}

Row colorCodeLegendTextBar(
    Color colorCode, String colorName, String description) {
  return Row(
    children: [
      new Text(colorName, style: TextStyle(color: colorCode, fontSize: 16.0)),
      new Text(description, style: TextStyle(color: colorCode, fontSize: 16.0)),
    ],
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
  );
}

ElevatedButton emailButton = ElevatedButton.icon(
  onPressed: () {
    launchMailto();
  },
  icon: Icon(Icons.email),
  label: Text('Email the developer'),
);

launchMailto() async {
  final mailtoLink = Mailto(
    to: ['joexvillegas@gmail.com'],
    subject: 'Shoopa Soundboard App Suggestion',
    body:
        'Please explain your comments below and I will reach back to you in my free time, thanks :)',
  );

  await launch('$mailtoLink');
}

Padding colorCodeTitle = Padding(
    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
    child: new Text(
      'Sound Color Code',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ));

Padding extraInfo = Padding(
    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
    child: new Text(
      'If you have any requests shoot me an email! Happy to quickly add :)',
      style: new TextStyle(
        fontSize: 12,
      ),
    ));
