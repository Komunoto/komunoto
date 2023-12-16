import 'dart:convert';
import 'package:http/http.dart' as http;
import '/global/env.dart';


//function registrasi phone
Future<http.Response> postApiRegistPhone(Map<String, dynamic> data) async {
  var response = await http.post(
    Uri.parse('$dev_url/auth/register'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );
  return response;
}

//function login phone
Future<http.Response> postApiLoginPhone(Map<String, dynamic> data) async {
  var response = await http.post(
    Uri.parse('$dev_url/auth/provider'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );
  return response;
}
