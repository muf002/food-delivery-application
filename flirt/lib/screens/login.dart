import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/authService.dart';
import './home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  final _emailController = TextEditingController();
  final passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                      child: Text('Login', style: TextStyle(fontSize: 25)),
                      onPressed: () {
                        loggingIn(
                            _emailController.text, passwordController.text);
                      },
                    )),
                SizedBox(height: 20),
                FlatButton(onPressed: null, child: Text('Forget Password')),
              ],
            )),
      ),
    );
  }

  loggingIn(email, password) async {
    try {
      final result = await AuthService().login(email, password);
      print(result);
      if (result['success']) {
        print('hello');
        final token = result['token'];
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('token', token);
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Home()));
      }
    } catch (err) {
      throw err;
    }
  }
}
