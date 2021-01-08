import 'dart:convert';

import 'package:http/http.dart' as http;

class DeleteService {
  menuDelete(id) async {
    print(id);
    final response = await http.delete('http://192.168.10.3:3000/menuDel/$id',
        headers: {"Content-Type": "application/json"});
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  orderDelete(id) async {
    print(id);
    final response = await http.delete('http://192.168.10.3:3000/orderDel/$id',
        headers: {"Content-Type": "application/json"});
    print(json.decode(response.body));
    return json.decode(response.body);
  }
}
