import 'package:flirt/screens/restLoginPage.dart';
import 'package:flutter/material.dart';
import '../services/getService.dart';
import './restLoginPage.dart';
import './menuPanel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerPanel extends StatefulWidget {
  List<dynamic> restaurants;
  SharedPreferences user;
  CustomerPanel(user) {
    this.user = user;
  }
  @override
  _CustomerPanelState createState() => _CustomerPanelState();
}

class _CustomerPanelState extends State<CustomerPanel> {
  bool isSearch = false;
  getRestaurant() async {
    final rest = await GetService().getRest();
    return rest;
  }

  List<Object> restaurants;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: !isSearch
            ? Text(
                "OrderGIK",
                style: TextStyle(color: Colors.orange[400]),
              )
            : TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Search...",
                ),
              ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSearch = !isSearch;
                  });
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.shopping_cart,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.logout,
                ),
              )),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: getRestaurant(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  for (var item in snapshot.data)
                    MyRestaurants(item['name'], widget.user)
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class MyRestaurants extends StatelessWidget {
  String restaurant;
  SharedPreferences token;
  MyRestaurants(String x, SharedPreferences user) {
    restaurant = x;
    token = user;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    MenuPage(this.restaurant, this.token)));
      },
      child: Card(
        elevation: 10.0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 8),
          child: Text(
            '$restaurant',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
