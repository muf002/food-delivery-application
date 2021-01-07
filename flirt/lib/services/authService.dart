import 'dart:convert';

import 'package:http/http.dart' as http;

String url = 'http://192.168.10.3:3000/login';

class AuthService {
  custLogin(email, password) async {
    try {
      final body = jsonEncode({"email": email, "password": password});
      var response = await http.post('http://192.168.10.3:3000/login',
          headers: {"Content-Type": "application/json"}, body: body);
      return json.decode(response.body);
    } catch (ex) {
      print(ex);
    }
  }

  restLogin(email, password) async {
    try {
      final body = jsonEncode({"username": email, "password": password});
      var response = await http.post('http://192.168.10.3:3000/restlogin',
          headers: {"Content-Type": "application/json"}, body: body);
      return json.decode(response.body);
    } catch (ex) {
      print(ex);
    }
  }
}
