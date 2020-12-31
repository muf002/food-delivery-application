import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_ink_well/image_ink_well.dart';
import './custloginPage.dart';
import './restLoginPage.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'OrderGIK',
          style: TextStyle(
            color: Colors.orange[400],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        leading: Icon(Icons.restaurant),
      ),
      body: Mywidget(),
    );
  }
}

class Mywidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(60, 30, 0, 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: RoundedRectangleImageInkWell(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => RestLogin()));
                },
                width: 300,
                height: 150,
                borderRadius: BorderRadius.all(const Radius.circular(20)),
                image: AssetImage('assets/17.jpg'),
              )),
              Container(
                  child: RoundedRectangleImageInkWell(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CustLogin()));
                },
                width: 300,
                height: 150,
                borderRadius: BorderRadius.all(const Radius.circular(20)),
                image: AssetImage('assets/18.jpg'),
              )),
            ]));
  }
}

// class Mywidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Stack(
//         children: <Widget>[
//           Container(
//             alignment: Alignment.center,
//             child: Image.network(
//                 'https://images.unsplash.com/photo-1551282952-3fb7c3a08f66?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'),
//             height: 250,
//             width: double.infinity,
//           ),
//           Container(
//             alignment: Alignment.center,
//             child: Text('YO'),
//           ),
//         ],
//       ),
//     );
//   }
// }
