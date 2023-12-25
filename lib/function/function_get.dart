import 'dart:convert';
import 'package:http/http.dart' as http;
import '/global/env.dart';

//function get onboarding
Future<List<dynamic>> getData() async {
  final response = await http.get(Uri.parse('$dev_url/onboarding'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List<dynamic> data = jsonResponse['data'];
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

//function get data interest car
Future<List<Map<dynamic, dynamic>>> getDataInterestCars() async {
  final response = await http.get(Uri.parse('$dev_url/interest/1'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List<dynamic> data = jsonResponse['data'];
    List<Map<String, dynamic>> cars = data.map((item) => {
      'id': int.parse(item['id']),
      'name': item['name'],
    }).toList();
    print(cars);
    return cars;
  } else {
    throw Exception('Failed to load data');
  }
}

//function get data interest motorcycle
Future<List<Map<dynamic, dynamic>>> getDataInterestMotorcycle() async {
  final response = await http.get(Uri.parse('$dev_url/interest/2'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List<dynamic> data = jsonResponse['data'];
    List<Map<String, dynamic>> cars = data.map((item) => {
      'id': int.parse(item['id']),
      'name': item['name'],
    }).toList();
    return cars;
  } else {
    throw Exception('Failed to load data');
  }
}

//function get data user
Future<Map<String, dynamic>> getDataUser(String token) async {
  final response = await http.get(
    Uri.parse('$dev_url/profile'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    },
  );
  
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final Map<String, dynamic> data = jsonResponse['data'];
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}
