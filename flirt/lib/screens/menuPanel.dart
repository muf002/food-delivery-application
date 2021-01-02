import 'package:flutter/material.dart';
import '../services/getService.dart';

class MenuPage extends StatefulWidget {
  var restaurant;
  MenuPage(rest) {
    restaurant = rest;
  }
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool isSearch = false;
  String rest;

  getMenu() async {
    final menu = await GetService().getMenu(widget.restaurant);
    return menu;
  }

  @override
  void initState() {
    super.initState();
    this.rest = widget.restaurant;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text(
          "$rest GIKI",
          style: TextStyle(color: Colors.orange[400]),
        ),
        actions: <Widget>[
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
          future: getMenu(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  for (var item in snapshot.data)
                    MenuItems(item['name'], item['price'])
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

class MenuItems extends StatelessWidget {
  String item;
  var val;
  MenuItems(String x, var y) {
    item = x;
    val = y;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: Text(
            '$item Rs. $val',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
