import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/registerion.dart';
import './custloginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './finalPage.dart';

class Order extends StatefulWidget {
  int price;
  var user;
  var restaurant;
  var pro;
  SharedPreferences token;
  Order(cost, user, rest, product, person) {
    price = cost;
    this.user = user;
    this.restaurant = rest;
    this.pro = product;
    token = person;
  }
  @override
  _OrderState createState() =>
      _OrderState(this.price, this.user, this.restaurant, this.pro, this.token);
}

class _OrderState extends State<Order> {
  final addressController = TextEditingController();
  int cost;
  int cost_del;
  _OrderState(cost, user, rest, product, token);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cost = widget.price;
    cost_del = cost + 30;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text(
          "One step away",
          style: TextStyle(color: Colors.orange[400]),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  widget.token.remove('tokken');
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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Delivery Address',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                SizedBox(
                  height: 13,
                ),
                new TextFormField(
                  controller: addressController,
                  decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Payment option',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  endIndent: 227,
                ),
                ListTile(
                  leading: Icon(
                    Icons.delivery_dining,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Cash on delivery',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Row(children: [
                  Text("Order:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("Rs. $cost",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ))
                ]),
                SizedBox(
                  height: 15,
                ),
                Row(children: [
                  Text("Delivery:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("Rs. 30",
                      style: TextStyle(fontSize: 20, color: Colors.black))
                ]),
                SizedBox(
                  height: 15,
                ),
                Row(children: [
                  Text("Total:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("Rs. $cost_del",
                      style: TextStyle(fontSize: 20, color: Colors.black))
                ]),
                SizedBox(
                  height: 100,
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () async {
                          await placeOrder();
                        },
                        child: const Text(
                          'Confirm Your Order',
                          style: TextStyle(fontSize: 20),
                        ),
                        color: Colors.blue,
                        textColor: Colors.white,
                        elevation: 5,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  placeOrder() async {
    var response = await Register().orderRegister(widget.pro, widget.user,
        widget.restaurant, this.cost_del, addressController.text);
    print(response);
    if (response['success']) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => FinalPage(widget.token)));
    } else {
      _showMyDialog(response['msg']);
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
