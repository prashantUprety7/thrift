import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../utils/api_endpoint_auth.dart';

class LoginController extends GetxController {

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail(BuildContext context) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {"email": emailcontroller.text.trim(), "password": passwordcontroller.text};
      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 0) {
          var token = json['data']['Token'];
          var userId = json['data']['Id'].toString();
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);
          await prefs?.setString('userId', userId);
          emailcontroller.clear();
          passwordcontroller.clear();
          Navigator.pushReplacementNamed(context, '/');
        } else if (json['code'] == 1) {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? 'Unknown error occurred';
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> logout() async {
    final SharedPreferences? prefs = await _prefs;
    await prefs?.remove('token');
    update(['isLoggedIn']);
  }
  Future<bool> isLoggedIn() async{
    final SharedPreferences prefs = await _prefs;
    final token = prefs.getString('token');
    return token != null;
  }
  Future<Map<String, dynamic>> getUserInfoById() async {
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
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw jsonDecode(response.body)['message'] ?? 'Unknown error occurred';
    }
  }

}