import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  List<dynamic> _cart = List<dynamic>();

  Cart(cart) {
    _cart = cart;
  }

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(cart) {
    print('hello');
    print(cart);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
          itemCount: widget._cart.length,
          itemBuilder: (context, index) {
            var item = widget._cart[index];
            final quan = item['quantity'];
            final name = item['item'];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  leading: Icon(
                    Icons.food_bank_sharp,
                    color: Colors.red,
                  ),
                  title: Text('$quan x $name'),
                  trailing: GestureDetector(
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onTap: () {}),
                ),
              ),
            );
          }),
    );
  }
}

// class MenuItems extends StatelessWidget {
//   String item;
//   var price;
//   MenuItems(String x, var y) {
//     item = x;
//     price = y;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
//       child: Card(
//         elevation: 4.0,
//         child: ListTile(
//           leading: Icon(
//             Icons.food_bank_sharp,
//             color: Colors.red,
//           ),
//           title: Text(item),
//           trailing: GestureDetector(
//               child: Icon(
//                 Icons.remove_circle,
//                 color: Colors.red,
//               ),
//               onTap: () {}),
//         ),
//       ),
//     );
//   }
// }
