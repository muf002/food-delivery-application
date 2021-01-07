import 'dart:async';

import 'package:flutter/material.dart';
import '../services/registerion.dart';
import './custloginPage.dart';

class CustRegister extends StatefulWidget {
  @override
  _CustRegisterState createState() => _CustRegisterState();
}

class _CustRegisterState extends State<CustRegister> {
  final _emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(top: 35),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(fontSize: 32),
                  ),
                  SizedBox(height: 20),
                  Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                decoration: InputDecoration(labelText: 'Name'),
                                controller: nameController,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                decoration: InputDecoration(labelText: 'Email'),
                                controller: _emailController,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                obscureText: true,
                                decoration:
                                    InputDecoration(labelText: 'Password'),
                                controller: passwordController,
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(height: 20),
                  SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.lightBlueAccent,
                        child: Text('Register', style: TextStyle(fontSize: 25)),
                        onPressed: () {
                          register(nameController.text, _emailController.text,
                              passwordController.text);
                        },
                      )),
                  SizedBox(height: 20),
                  FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CustLogin()));
                      },
                      child: Text('Sign In')),
                ],
              ),
            ),
          ),
        )));
  }

  register(name, email, password) async {
    try {
      final result = await Register().customerRegister(name, email, password);
      print(result);
      if (result['success']) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => CustLogin()));
      } else {
        await _showMyDialog(result['msg']);
      }
    } catch (err) {
      throw err;
    }
  }

  Future<void> _showMyDialog(result) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(result),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
