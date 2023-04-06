import 'dart:convert';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class UserScreenController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<Map<String, dynamic>> getUserInfo() async {
    final SharedPreferences prefs = await _prefs;
    final token = prefs.getString('token') ?? '';
    final userId = prefs.getString('userId') ?? '';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.parse('http://restapi.adequateshop.com/api/users/$userId');
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw jsonDecode(response.body)['message'] ?? 'Unknown error occurred';
    }
  }
}
