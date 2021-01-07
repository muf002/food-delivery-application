import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/getService.dart';
import '../services/delService.dart';
import '../services/registerion.dart';

class EditMenuPage extends StatefulWidget {
  SharedPreferences token;
  EditMenuPage(user) {
    token = user;
  }
  @override
  _MenuPageState createState() => _MenuPageState(this.token);
}

class _MenuPageState extends State<EditMenuPage> {
  _MenuPageState(user);
  String rest;
  void initState() {
    super.initState();
    rest = widget.token.getString('token');
    getMenue();
  }

  final nameController = TextEditingController();
  final priceController = TextEditingController();

  List menu = [
    'Chicken Burger',
    200,
    'Zinger Burger',
    300,
    'Cheese Steak',
    550,
    'Shawarma',
    150
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          title: Text(
            "My Menu",
            style: TextStyle(
              color: Colors.orange[400],
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.grey[850],
                  child: Center(
                    child: Text(
                      'Order History',
                      style: (TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
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
                      future: getMenue(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                                return menuItems(
                                    item['name'], item['price'], item['_id']);
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return myAdder();
                });
          },
          tooltip: 'Add an Item',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  getMenue() async {
    final orders = await GetService().getMenuRes(this.rest);
    return orders;
  }

  menuItems(name, price, id) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(1),
        child: ListTile(
            leading: Icon(
              Icons.emoji_food_beverage,
              color: Colors.orange[800],
            ),
            title: Row(children: [
              Text(
                '$name',
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Text(
                'Rs. $price',
                style: TextStyle(fontSize: 18),
              ),
            ]),
            trailing: GestureDetector(
                child: Icon(Icons.delete, color: Colors.red),
                onTap: () async {
                  await removeMenu(id);
                  // setState(() {
                  //   widget._cart
                  //       .removeWhere((element) => element['item'] == name);
                  //   total();
                })),
      ),
    );
  }

  removeMenu(id) async {
    final res = await DeleteService().menuDelete(id);
    setState(() {});
  }

  addItem(name, price) async {
    final response = await Register().menuRegister(name, price, this.rest);
    print(response);
    setState(() {});
    Navigator.of(context).pop();
  }

  myAdder() {
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
              padding: EdgeInsets.only(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Item Name',
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Item Price',
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.green,
                      child: Text(
                        "Enter",
                      ),
                      onPressed: () async {
                        await addItem(
                            nameController.text, priceController.text);
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
  }
}
