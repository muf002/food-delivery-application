import 'package:flutter/material.dart';
import './placeOrder.dart';

class Cart extends StatefulWidget {
  List<dynamic> _cart = List<dynamic>();

  Cart(cart) {
    _cart = cart;
  }

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  int total_price;
  _CartState(cart);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    total();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          title: Text(
            "Cart",
            style: TextStyle(color: Colors.orange[400]),
          ),
          actions: <Widget>[
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
                  child: ListView.builder(
                      itemCount: widget._cart.length,
                      itemBuilder: (context, index) {
                        var item = widget._cart[index];
                        final quan = item['quantity'];
                        final name = item['item'];
                        final price = item['price'] * quan;
                        return cartitems(quan, name, price);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: Card(
                    elevation: 4.0,
                    child: ListTile(
                      leading: Icon(
                        Icons.food_bank_sharp,
                        color: Colors.red,
                      ),
                      title: Text(
                        'Total: $total_price Rs',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Order(total_price)));
                        },
                        child: const Text(
                          'Checkout',
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
        ));
  }

  cartitems(quan, name, price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Card(
        elevation: 4.0,
        child: ListTile(
          leading: Icon(
            Icons.food_bank_sharp,
            color: Colors.red,
          ),
          title: Text(
            '$quan x $name  \nRs. $price',
            style: TextStyle(fontSize: 20),
          ),
          trailing: GestureDetector(
              child: Icon(Icons.remove_circle, color: Colors.red),
              onTap: () {
                setState(() {
                  widget._cart
                      .removeWhere((element) => element['item'] == name);
                  total();
                });
              }),
        ),
      ),
    );
  }

  total() {
    var total_p = 0;
    for (var item in widget._cart) {
      total_p = total_p + (item['price'] * item['quantity']);
    }
    setState(() {
      total_price = total_p;
      print(total_price);
    });
  }
}
