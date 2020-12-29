import 'package:http/http.dart' as http;
import 'dart:convert';

class Register {
  customerRegister(name, email, password) async {
    print(name + email + password);
    try {
      final body =
          jsonEncode({"name": name, "email": email, "password": password});
      var response = await http.post('http://192.168.10.8:3000/custRegister',
          headers: {"Content-Type": "application/json"}, body: body);
      return json.decode(response.body);
    } catch (ex) {
      print(ex);
    }
  }
}
