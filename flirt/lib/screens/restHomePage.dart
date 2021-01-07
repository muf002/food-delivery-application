import 'package:flutter/material.dart';
import './editMenuPage.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/getService.dart';

class RestaurantHome extends StatefulWidget {
  SharedPreferences token;
  RestaurantHome(user) {
    token = user;
  }
  @override
  _RestaurantHomeState createState() => _RestaurantHomeState(this.token);
}

class _RestaurantHomeState extends State<RestaurantHome> {
  _RestaurantHomeState(user);
  String rest;
  void initState() {
    super.initState();
    rest = widget.token.getString('token');
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                "Active Orders",
                style: TextStyle(
                  color: Colors.orange[400],
                ),
              ),
              backgroundColor: Colors.grey[850],
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: RaisedButton(
                      color: Colors.grey[850],
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    EditMenuPage(widget.token)));
                      },
                      child: Center(
                        child: Text(
                          'Menu',
                          style: (TextStyle(fontSize: 20, color: Colors.white)),
                        ),
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
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Expanded(
                      child: FutureBuilder(
                          future: getOrder(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    var item = snapshot.data[index];
                                    // final quan = item['quantity'];
                                    // final name = item['item'];
                                    // final price = item['price'] * quan;
                                    return activeOrders(
                                        item['user']['name'],
                                        item['product'],
                                        item['price'],
                                        item['address'],
                                        item['_id']);
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    )
                  ],
                ),
              ),
            )));
  }

  activeOrders(user, product, price, address, id) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    insetPadding: EdgeInsets.all(10),
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                                child: GestureDetector(
                              child: Icon(Icons.close),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            )),
                          ),
                        ),
                        Form(
                          child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                for (var item in product) items(item),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    color: Colors.green,
                                    child: Text(
                                      "Mark as Complete",
                                    ),
                                    onPressed: () async {
                                      await delivered(id);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Padding(
            padding: EdgeInsets.all(2),
            child: ListTile(
              leading: Icon(
                Icons.restaurant_menu,
                color: Colors.blueGrey,
              ),
              title: Text(
                '$user |  Amount: $price',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              tileColor: Colors.grey[300],
              subtitle: Text('$address'),
              isThreeLine: true,
            ),
          )),
    );
  }

  getOrder() async {
    final orders = await GetService().getOrderRes(this.rest);
    return orders;
  }

  items(products) {
    var name = products['item'];
    var quant = products['quantity'];
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '$quant x $name',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  delivered(id) async {
    final res = await GetService().orderDelivered(id);
    setState(() {
      print('reload');
    });
    Navigator.of(context).pop();
  }
}
