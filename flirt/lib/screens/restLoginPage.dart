import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/authService.dart';
import './home.dart';

class RestLogin extends StatefulWidget {
  @override
  _RestLoginState createState() => _RestLoginState();
}

class _RestLoginState extends State<RestLogin> {
  @override
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: EdgeInsets.only(top: 100),
      child: Center(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 32),
                ),
                SizedBox(height: 20),
                Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              decoration:
                                  InputDecoration(labelText: 'username'),
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
                      child: Text('Login', style: TextStyle(fontSize: 25)),
                      onPressed: () {
                        loggingIn(
                            usernameController.text, passwordController.text);
                      },
                    )),
                SizedBox(height: 20),
                FlatButton(onPressed: null, child: Text('Forget Password')),
              ],
            )),
      ),
    )));
  }

  loggingIn(username, password) async {
    try {
      final result = await AuthService().restLogin(username, password);
      print(result);
      if (result['success']) {
        final token = result['token'];
        SharedPreferences restPref = await SharedPreferences.getInstance();
        await restPref.setString('token', token);
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Home()));
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
