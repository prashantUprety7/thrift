import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../utils/api_endpoint_auth.dart';

class RegistrationController extends GetxController {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var userInfo = {}.obs;

  Future<void> registerWithEmail(BuildContext context) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.registerEmail);
      Map body = {
        "name": namecontroller.text,
        "email": emailcontroller.text.trim(),
        "password": passwordcontroller.text
      };
      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 0) {
          var token = json['data']['Token'];
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);
          emailcontroller.clear();
          passwordcontroller.clear();
          Navigator.pushReplacementNamed(context, '/auth');
          Fluttertoast.showToast(
            msg: 'Successfully registered account.Please log in.',
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 13.0,
          );

        } else {
          throw jsonDecode(response.body)["Message"] ?? 'Unknown error occured';
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? 'Unknown error occured';
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  }
