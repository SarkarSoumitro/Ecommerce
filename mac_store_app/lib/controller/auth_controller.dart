import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_app/model/user.dart';
import 'package:mac_store_app/services/manage_http_response.dart';
import 'package:mac_store_app/global_varieable.dart';
import 'package:mac_store_app/view/screens/authentication_screens/login_screen.dart';
import 'package:mac_store_app/view/screens/main_screen.dart';

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      User user = User(
        id: "",
        state: "",
        city: "",
        email: email,
        fullName: fullname,
        locality: "",
        password: password,
        token: "",
      );
      http.Response response = await http.post(
        Uri.parse('$url/api/signup'),
        body: user
            .tojson(), //convert the user object to json for the request body
        headers: <String, String>{
          //set the headers for the request
          'Content-Type':
              'application/json; charset=UTF-8', //specify the context type as json
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          showSnackBar(context, "Account has been Created for you");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$url/api/signin"),
        body: jsonEncode({
          "email": email, //include the email in the request body
          "password": password, //include the password in the request body
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false,
          );
          showSnackBar(context, "Login successfully");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }
}
