import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './customerPanel.dart';

class FinalPage extends StatelessWidget {
  @override
  SharedPreferences token;
  FinalPage(user) {
    token = user;
  }
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.check,
                color: Colors.green,
                size: 100,
              ),
              Container(
                child: Text(
                  'Your order has been placed',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 100, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: FloatingActionButton.extended(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.black,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CustomerPanel(this.token)));
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text('Return to Homepage'),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
