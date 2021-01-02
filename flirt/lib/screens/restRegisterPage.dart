import 'dart:async';

import 'package:flutter/material.dart';
import '../services/registerion.dart';
import './restLoginPage.dart';

class RestRegister extends StatefulWidget {
  @override
  _RestRegisterState createState() => _RestRegisterState();
}

class _RestRegisterState extends State<RestRegister> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Admin',
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
          padding: EdgeInsets.only(top: 60),
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
                                decoration:
                                    InputDecoration(labelText: 'Username'),
                                controller: usernameController,
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
                          register(nameController.text, usernameController.text,
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
                                    RestLogin()));
                      },
                      child: Text('Sign In')),
                ],
              ),
            ),
          ),
        )));
  }

  register(name, username, password) async {
    try {
      final result =
          await Register().restaurantRegister(name, username, password);
      print(result);
      if (result['success']) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => RestLogin()));
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
      barrierDismissible: false,
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
