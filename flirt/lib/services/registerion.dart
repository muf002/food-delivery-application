import 'package:http/http.dart' as http;
import 'dart:convert';

class Register {
  customerRegister(name, email, password) async {
    print(name + email + password);
    try {
      final body =
          jsonEncode({"name": name, "email": email, "password": password});
      var response = await http.post('http://192.168.10.3:3000/custRegister',
          headers: {"Content-Type": "application/json"}, body: body);
      return json.decode(response.body);
    } catch (ex) {
      print(ex);
    }
  }

  restaurantRegister(name, username, password) async {
    print(name + username + password);
    try {
      final body = jsonEncode(
          {"name": name, "username": username, "password": password});
      var response = await http.post('http://192.168.10.3:3000/restRegister',
          headers: {"Content-Type": "application/json"}, body: body);
      return json.decode(response.body);
    } catch (ex) {
      print(ex);
    }
  }

  orderRegister(items, user, restaurant, price, address) async {
    try {
      final body = jsonEncode({
        "product": items,
        "user": user,
        "restaurant": restaurant,
        "price": price,
        "address": address
      });
      print(body);
      var response = await http.post('http://192.168.10.3:3000/placeOrder',
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: body);
      return json.decode(response.body);
    } catch (ex) {
      print(ex);
    }
  }

  menuRegister(name, price, token) async {
    final response = await http.get(
      'http://192.168.10.3:3000/restaurant/$token',
      headers: {"Content-Type": "application/json"},
    );
    final restaurant = json.decode(response.body)['_id'];
    try {
      final body = jsonEncode({
        "name": name,
        "price": price,
        "restaurant": restaurant,
      });
      print(body);
      var response = await http.post('http://192.168.10.3:3000/menuEnter',
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: body);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (ex) {
      print(ex);
    }
  }
}
