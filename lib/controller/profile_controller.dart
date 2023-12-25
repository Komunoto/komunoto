import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:komunoto/function/function_get.dart';

class ProfileController {
  ValueNotifier<User?> userNotifier = ValueNotifier<User?>(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? token;

  Future<void> getUserData() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        userNotifier.value = currentUser;
      }
    } catch (e) {
      print(e);
    }
  }



  
}
