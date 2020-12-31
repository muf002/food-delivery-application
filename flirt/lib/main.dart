import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import './screens/restloginPage.dart';
import './screens/restRegisterPage.dart';
import './screens/frontPage.dart';

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

// class BodyWidget extends StatefulWidget {
//   @override
//   BodyWidgetState createState() {
//     return new BodyWidgetState();
//   }
// }

// class BodyWidgetState extends State<BodyWidget> {
//   String serverResponse = 'Server response';

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(32.0),
//       child: Align(
//         alignment: Alignment.topCenter,
//         child: SizedBox(
//           width: 200,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               RaisedButton(
//                 child: Text('Send request to server'),
//                 onPressed: () {
//                   _makeGetRequest();
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(serverResponse),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _makeGetRequest() async {
//     Response response = await get('http://192.168.10.18:3000/login');
//     String res = response.body.toString().trim();
//     setState(() {
//       serverResponse = res;
//     });
//   }
// }
