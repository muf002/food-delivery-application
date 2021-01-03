import 'package:flutter/material.dart';
import './screens/menuPanel.dart';
import './screens/restLoginPage.dart';
import './screens/restRegisterPage.dart';
import './screens/frontPage.dart';
import './screens/customerPanel.dart';
import './screens/custLoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

// GestureDetector(
//                   onTap: () {},
//                   child: new Stack(children: <Widget>[
//                     new Padding(
//                         padding: EdgeInsets.only(top: 15),
//                         child: Icon(Icons.shopping_cart)),
//                     new Positioned(
//                       // draw a red marble
//                       top: 12.0,
//                       right: 0.0,
//                       child: new Icon(Icons.brightness_1,
//                           size: 8.0, color: Colors.redAccent),
//                     ),
//                   ]))
