import 'package:flutter/material.dart';

import 'ghflutter.dart';
import 'strings.dart';

// When function has only one statement, you can put in one line

/*
void main() {
  return runApp(new GHFlutterApp());
}
*/

void main() => runApp(new GHFlutterApp());

// 1º- Your app itself is a StatelessWidget
// 2º- You override the widget build() method to create your app widget
// 3º- You're using the MaterialApp widget that provides a number of components needed for apps following Material Design.

class GHFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(

      title: Strings.appTitle,
      theme: new ThemeData(primaryColor: Colors.purple.shade500),
      home: new GHFlutter(),

    );

  }
}


