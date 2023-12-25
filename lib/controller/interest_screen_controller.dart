import 'package:flutter/material.dart';
import 'package:komunoto/function/function_get.dart';
import 'package:komunoto/function/function_post.dart';
import 'package:komunoto/global/env.dart';
import 'package:komunoto/view/home_screen/home_screen.dart';
import 'package:komunoto/view/snack_bar/bar_error.dart';

class InterestScreenController {
  String? token;
  //get data car and make it list of map
  Future<List<Map<dynamic, dynamic>>> getCars() async {
    List<Map<dynamic, dynamic>> cars = await getDataInterestCars();
    return cars;
  }

  //get data motorcycle and make it list of map
  Future<List<Map<dynamic, dynamic>>> getMotorcycle() async {
    List<Map<dynamic, dynamic>> motorcycle = await getDataInterestMotorcycle();
    return motorcycle;
  }

  Future<void> initializeToken() async {
    Map<String, String?> tokenAndId = await getToken();
    token = tokenAndId['token'];
    // Now you can use the token in your BerandaPage
  }

  Future<void> postSelectedInterests(
      BuildContext context, List<int> data) async {
    if (token == null) {
      throw Exception('Token is null');
    }
    var response = await postInterest(token!, data);
   

    if (response.statusCode == 200) {
      // If the server returns a 201 response, navigate to the HomeScreen.
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      // If the server did not return a 201 response, throw an exception.
      BarError.showSnackBar('Check your internet connection');
    }
  }
}
