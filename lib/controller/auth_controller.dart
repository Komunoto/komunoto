import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:komunoto/function/function_post.dart';
import 'package:komunoto/view/home_screen/home_screen.dart';
import 'package:komunoto/view/interest_screen/interest_screen.dart';
import 'package:komunoto/view/snack_bar/bar_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final BuildContext context;
  String? phoneNumber;
  String? email;
  String? uid;
  AuthController(this.context);

  void postLogin(String? phoneNumber, String uid, String? email) async {
    if (phoneNumber != null) {
      Map<String, dynamic> data = {
        'auth': phoneNumber,
        'provider': 5,
        'uuid': uid,
      };
      http.Response response = await postApiLoginPhone(data);
      print(response.statusCode);
      // Now you can use the response
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        String token = jsonData['data']
            ['token']; // Extract the token from the 'data' object
        String id = jsonData['data']['user']
            ['id']; // Extract the token from the 'data' object
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('id', id);
        onLoginSuccess();
      } else if (response.statusCode == 404) {
        // If the server returns an unsuccessful response code,
        postRegistData(phoneNumber, phoneNumber, uid);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: ((context) => HomeScreen())));
      } else {
        // If the server returns an unsuccessful response code,
        BarError.showSnackBar('Check your internet connection');
      }
    } else {
      Map<String, dynamic> data = {
        'auth': email,
        'provider': 2,
        'uuid': uid,
      };
      http.Response response = await postApiLoginPhone(data);
      print(response.statusCode);
      // Now you can use the response
      if (response.statusCode == 200) {
        onLoginSuccess();
      } else if (response.statusCode == 404) {
        // If the server returns an unsuccessful response code,
        postRegistData(email, phoneNumber, uid);
      } else {
        // If the server returns an unsuccessful response code,
        BarError.showSnackBar('Check your internet connection');
      }
    }
  }

  void postRegistData(String? phoneNumber, String? email, String? uid) async {
    if (phoneNumber != null) {
      Map<String, dynamic> data = {
        'email': null, // kosong kalo pake phone number
        'phoneNumber': phoneNumber, //kosong kalo register pake email
        'provider': 5,
        'uuid': uid // jika provider selain 1
      };
      http.Response response = await postApiRegistPhone(data);
      print(response.body);
      // Dekode response body
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Now you can use the response
      if (response.statusCode == 200) {
        onRegistSuccess();
      } else if (response.statusCode == 404) {
        // If the server returns an unsuccessful response code,
        BarError.showSnackBar('Failed To Register');
      } else {
        // If the server returns an unsuccessful response code,
        BarError.showSnackBar('Check your internet connection');
      }
    } else {
      Map<String, dynamic> data = {
        'email': email, // kosong kalo pake phone number
        'phoneNumber': null, //kosong kalo register pake email
        'provider': 2,
        'uuid': uid // jika provider selain 1
      };
      http.Response response = await postApiRegistPhone(data);
      // Dekode response body
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      // Now you can use the response
      if (response.statusCode == 200) {
        onRegistSuccess();
      } else if (response.statusCode == 404) {
        // If the server returns an unsuccessful response code,
        BarError.showSnackBar('Failed To Register');
      } else {
        // If the server returns an unsuccessful response code,
        BarError.showSnackBar('Check your internet connection');
      }
    }
  }

  void onLoginSuccess() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const HomeScreen(),
      ),
    );
  }

  void onRegistSuccess() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const InterestScreen(),
      ),
    );
  }
}
