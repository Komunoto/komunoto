import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:komunoto/after_login.dart';
import 'package:komunoto/view/form/vehicle_form.dart';
import 'package:komunoto/view/function/function_post.dart';
import 'package:komunoto/view/home_screen/home_screen.dart';
import 'package:komunoto/view/interest_screen/interest_screen.dart';
import 'package:komunoto/view/snack_bar/bar_error.dart';

class AuthController {
  final BuildContext context;

  AuthController(this.context);

  void postLogin(String? phoneNumber, String uid, String? email, String? provider) async {
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
        onLoginSuccess();
      } else if (response.statusCode == 404) {
        // If the server returns an unsuccessful response code,
        postRegistData(email, phoneNumber, uid);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: ((context) => HomeScreen())));
      } else {
        // If the server returns an unsuccessful response code,
        BarError.showSnackBar('Check your internet connection');
      }
    } else {
      Map<String, dynamic> data = {
        'auth': email,
        'provider': 5,
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
    Map<String, dynamic> data = {
      // 'phone': phoneNumber,
      // 'service': 0,
      "email": "email@email.com", // kosong kalo pake phone number
      "phoneNumber": "", //kosong kalo register pake email
      "provider": 2,
      "uuid": "email@email.com" // jika provider selain 1
    };
    http.Response response = await postApiRegistPhone(data);
    // Dekode response body
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    // Now you can use the response
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => HomeScreen())));
    } else if (response.statusCode == 404) {
      // If the server returns an unsuccessful response code,
      BarError.showSnackBar('Failed To Register');
    } else {
      // If the server returns an unsuccessful response code,
      BarError.showSnackBar('Check your internet connection');
    }
  }

  void onLoginSuccess() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const AfterLogin(),
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
