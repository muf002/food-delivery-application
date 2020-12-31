import 'package:http/http.dart' as http;
import 'dart:convert';

class Register {
  customerRegister(name, email, password) async {
    print(name + email + password);
    try {
      final body =
          jsonEncode({"name": name, "email": email, "password": password});
      var response = await http.post('http://192.168.10.2:3000/custRegister',
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
      var response = await http.post('http://192.168.10.2:3000/restRegister',
          headers: {"Content-Type": "application/json"}, body: body);
      return json.decode(response.body);
    } catch (ex) {
      print(ex);
    }
  }
}
