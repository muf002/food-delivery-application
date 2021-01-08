import 'package:http/http.dart' as http;
import 'dart:convert';

class GetService {
  getRest() async {
    final response = await http.get('http://192.168.10.3:3000/restaurants',
        headers: {"Content-Type": "application/json"});
    return json.decode(response.body);
  }

  getMenu(restaurant) async {
    print(restaurant);
    //final uri = new Uri.http('http://192.168.10.2:3000/menu/', restaurant);
    final response = await http.get(
      'http://192.168.10.3:3000/menu/$restaurant',
      headers: {"Content-Type": "application/json"},
    );
    return json.decode(response.body);
  }

  getUser(token) async {
    print(token);
    final response = await http.get(
      'http://192.168.10.3:3000/user/$token',
      headers: {"Content-Type": "application/json"},
    );
    return json.decode(response.body);
  }

  getOrderRes(rest) async {
    print(rest);
    final response = await http.get(
      'http://192.168.10.3:3000/restaurant/$rest',
      headers: {"Content-Type": "application/json"},
    );
    final restaurant = json.decode(response.body)['name'];
    final order = await http.get(
      'http://192.168.10.3:3000/getOrderRes/$restaurant',
      headers: {"Content-Type": "application/json"},
    );
    print(json.decode(order.body));
    return json.decode(order.body);
  }

  getOrderHis(rest) async {
    print(rest);
    final response = await http.get(
      'http://192.168.10.3:3000/restaurant/$rest',
      headers: {"Content-Type": "application/json"},
    );
    final restaurant = json.decode(response.body)['name'];
    final order = await http.get(
      'http://192.168.10.3:3000/getOrderHis/$restaurant',
      headers: {"Content-Type": "application/json"},
    );
    print(json.decode(order.body));
    return json.decode(order.body);
  }

  getOrderHisCust(user) async {
    print(user);
    final response = await http.get(
      'http://192.168.10.3:3000/user/$user',
      headers: {"Content-Type": "application/json"},
    );
    final person = json.decode(response.body)['name'];
    final order = await http.get(
      'http://192.168.10.3:3000/getOrderHisCust/$person',
      headers: {"Content-Type": "application/json"},
    );
    print(json.decode(order.body));
    return json.decode(order.body);
  }

  orderDelivered(id) async {
    // final body = jsonEncode({"id": id});
    final response = await http.put(
      'http://192.168.10.3:3000/delivered/$id',
      headers: {"Content-Type": "application/json"},
    );
    return json.decode(response.body);
  }

  getMenuRes(rest) async {
    print(rest);
    final response = await http.get(
      'http://192.168.10.3:3000/restaurant/$rest',
      headers: {"Content-Type": "application/json"},
    );
    final restaurant = json.decode(response.body)['name'];
    final order = await http.get(
      'http://192.168.10.3:3000/getMenuRes/$restaurant',
      headers: {"Content-Type": "application/json"},
    );
    print(json.decode(order.body));
    return json.decode(order.body);
  }
}
