import 'package:shared_preferences/shared_preferences.dart';

// url development
const dev_url = 'http://178.16.138.109:4000';


Future<Map<String, String?>> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  return {'token': token};
}


