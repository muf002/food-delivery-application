import 'package:flutter/material.dart';
import './screens/menuPanel.dart';
import './screens/restLoginPage.dart';
import './screens/restRegisterPage.dart';
import './screens/frontPage.dart';
import './screens/customerPanel.dart';
import './screens/custLoginPage.dart';
import './screens/restHomePage.dart';

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
