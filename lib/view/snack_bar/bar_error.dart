import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarError{
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String text) {
    final snackBar = SnackBar(
        content: Text(
          text,
          style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 206, 32, 47));

    if (messengerKey.currentState != null) {
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
  }
}