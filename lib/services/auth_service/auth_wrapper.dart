import 'dart:convert';
import'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthWrapper {
  static const _apiUrl = 'https://reqres.in/api';
  late String _token;

  bool get isAuthenticated {
    return _token.isNotEmpty;
  }

  String? get token {
    return isAuthenticated ? _token : null;
  }

  Future<bool> login({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/login'),
      body: json.encode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _token = data['token'];
      await _storeToken();
      return true;
    } else {
      _token = '';
      return false;
    }
  }

  Future<bool> signup({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('${_apiUrl}signup'),
      body: json.encode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _token = data['token'];
      await _storeToken();
      return true;
    } else {
      _token = '';
      return false;
    }
  }

  Future<void> _storeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _token);
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      _token = token;
    }
  }

  Future<void> logout() async {
    _token = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}