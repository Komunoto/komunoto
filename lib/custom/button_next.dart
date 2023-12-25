import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonNext extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ButtonNext({super.key, required this.text, required this.onPressed});

  @override
 Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width * 0.8, // 80% of screen width
        height: height * 0.06, // 6% of screen height
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        decoration: ShapeDecoration(
           gradient: const LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [
              
              Color(0xB3EE7D32),
              Color(0xCCEE7D32),
              Color(0xE6EE7D32),
              Color(0xE6EE7D32),
              Color(0xE6EE7D32),
              Color(0xFFEE7D32),
              Color(0xFFEE7D32),
              Color(0xFFEE7D32),
              Color(0xFFEE7D32),
              Color(0xFFEE7D32),
              Color(0xFFEE7D32),
           

              // ... other colors
            ],
          ),
          shape: RoundedRectangleBorder(
           
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFFAFAFA),
            ),
          ),
        ),
      ),
    );
  }
}