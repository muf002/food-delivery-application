import 'package:http/http.dart' as http;
import 'dart:convert';

class GetService {
  getRest() async {
    final response = await http.get('http://192.168.10.2:3000/restaurants',
        headers: {"Content-Type": "application/json"});
    return json.decode(response.body);
  }

  getMenu(restaurant) async {
    print(restaurant);
    //final uri = new Uri.http('http://192.168.10.2:3000/menu/', restaurant);
    final response = await http.get(
      'http://192.168.10.2:3000/menu/$restaurant',
      headers: {"Content-Type": "application/json"},
    );
    return json.decode(response.body);
  }
}
