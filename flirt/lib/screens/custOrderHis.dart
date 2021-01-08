import 'package:flutter/material.dart';
import './editMenuPage.dart';
import 'package:http/http.dart';
import './custLoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/getService.dart';
import '../services/delService.dart';

class CustOrderHistory extends StatefulWidget {
  SharedPreferences token;
  CustOrderHistory(user) {
    token = user;
  }
  @override
  _CustOrderHistoryState createState() => _CustOrderHistoryState(this.token);
}

class _CustOrderHistoryState extends State<CustOrderHistory> {
  _CustOrderHistoryState(user);
  String person;
  void initState() {
    super.initState();
    person = widget.token.getString('token');
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                "Order History",
                style: TextStyle(
                  color: Colors.orange[400],
                ),
              ),
              backgroundColor: Colors.grey[850],
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        widget.token.remove('tokken');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CustLogin()));
                      },
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
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text('Active Orders',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      indent: 20,
                      endIndent: 20,
                    ),
                    new Expanded(
                      child: FutureBuilder(
                          future: getOrder(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                        color: Colors.black,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    var item = snapshot.data[index];
                                    if (!item['isDelivered']) {
                                      return activeOrders(
                                          item['user']['name'],
                                          item['product'],
                                          item['price'],
                                          item['address'],
                                          item['_id'],
                                          item['isDelivered']);
                                    }
                                    return Padding(padding: EdgeInsets.all(0));
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text('Past Orders',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    new Expanded(
                        child: FutureBuilder(
                            future: getOrder(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          color: Colors.black,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      var item = snapshot.data[index];
                                      if (item['isDelivered']) {
                                        return activeOrders(
                                            item['user']['name'],
                                            item['product'],
                                            item['price'],
                                            item['address'],
                                            item['_id'],
                                            item['isDelivered']);
                                      }
                                      return Padding(
                                          padding: EdgeInsets.all(0));
                                    });
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }))
                  ],
                ),
              ),
            )));
  }

  activeOrders(user, product, price, address, id, isDel) {
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
                Icons.fastfood,
                color: Colors.blueGrey,
              ),
              title: Text(
                '$user |  Amount: $price',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              trailing: GestureDetector(
                  child: Icon(Icons.done_all, color: Colors.red),
                  onTap: () async {}),
              subtitle: Text('$address'),
              isThreeLine: true,
            ),
          )),
    );
  }

  getOrder() async {
    final orders = await GetService().getOrderHisCust(this.person);
    return orders;
  }

  removeOrder(id) async {
    final res = await DeleteService().orderDelete(id);
    setState(() {});
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
