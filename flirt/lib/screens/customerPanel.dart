import 'package:flirt/screens/restLoginPage.dart';
import 'package:flutter/material.dart';
import '../services/getService.dart';
import './custLoginPage.dart';
import './menuPanel.dart';
import './custOrderHis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CustOrderHistory(widget.user)));
                },
                child: Icon(
                  Icons.history,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  widget.user.remove('tokken');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CustLogin()));
                },
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: new FittedBox(
            child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: Color(0x802196F3),
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MenuPage(this.restaurant, this.token)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: myDetailsContainer1(restaurant),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.contain,
                        alignment: Alignment.topRight,
                        image: AssetImage('assets/food.jpg'),
                      ),
                    ),
                  )
                ],
              )),
        )),
      ),
    );
  }

  Widget myDetailsContainer1(rest) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "$rest",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Container(
              //     child: Text(
              //   "4.3",
              //   style: TextStyle(
              //     color: Colors.black54,
              //     fontSize: 18.0,
              //   ),
              // )),
              // Container(
              //   child: Icon(
              //     FontAwesomeIcons.solidStar,
              //     color: Colors.amber,
              //     size: 15.0,
              //   ),
              // ),
              // Container(
              //   child: Icon(
              //     FontAwesomeIcons.solidStar,
              //     color: Colors.amber,
              //     size: 15.0,
              //   ),
              // ),
              // Container(
              //   child: Icon(
              //     FontAwesomeIcons.solidStar,
              //     color: Colors.amber,
              //     size: 15.0,
              //   ),
              // ),
              // Container(
              //   child: Icon(
              //     FontAwesomeIcons.solidStar,
              //     color: Colors.amber,
              //     size: 15.0,
              //   ),
              // ),
              // Container(
              //   child: Icon(
              //     FontAwesomeIcons.solidStarHalf,
              //     color: Colors.amber,
              //     size: 15.0,
              //   ),
              // ),
              // Container(
              //     child: Text(
              //   "(321) \u00B7 0.9 mi",
              //   style: TextStyle(
              //     color: Colors.black54,
              //     fontSize: 18.0,
              //   ),
              // )),
            ],
          )),
        ),
        // Container(
        //     child: Text(
        //   "Pastries \u00B7 Phoenix,AZ",
        //   style: TextStyle(
        //       color: Colors.black54,
        //       fontSize: 18.0,
        //       fontWeight: FontWeight.bold),
        // )),
      ],
    );
  }
}
