import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:komunoto/controller/auth_controller.dart';
import 'package:komunoto/custom/button_confirmation_phone.dart';

class AuthNumberPhone extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const AuthNumberPhone({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  State<AuthNumberPhone> createState() => _AuthNumberPhoneState();
}

class _AuthNumberPhoneState extends State<AuthNumberPhone> {
  final List<TextEditingController> _controllers =
      List<TextEditingController>.generate(
    6,
    (_) => TextEditingController(),
  );

  String getData() {
    String otp = _controllers.map((controller) => controller.text).join();
    return otp;
  }

  @override
  Widget build(BuildContext context) {
    AuthController auth = AuthController(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: width,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Verifikasi OTP',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 30 * width / 720,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 50 * width / 720,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Silahkan masukan kode verifikasi yang sudah dikirim ke ' +
                      widget.phoneNumber,
                  style: GoogleFonts.poppins(
                      color: const Color(0x7F2A2A2A),
                      fontSize: 25 * width / 720,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List<Widget>.generate(
                    6,
                    (index) => SizedBox(
                        height: 50,
                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _controllers[index],
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: const Color(0x26EE7D32),
                            filled: true,
                            counterText: '',
                          ),
                          onChanged: (value) {
                            if (value.length == 1 &&
                                index < _controllers.length - 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: ButtonConfirmationPhone(
                        text: 'Konfirmasi',
                        onPressed: () async {
                          final credential = PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: getData());
                          try {
                            final userCredential = await FirebaseAuth.instance
                                .signInWithCredential(credential);
                            final user = FirebaseAuth.instance.currentUser;

                            if (user != null) {
                              // The user exists, navigate to the AfterLogin page
                              auth.postLogin(widget.phoneNumber, user.uid, user.email);
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-verification-code') {
                              print(
                                  'The provided verification code is invalid.');
                            }
                          }
                        }))
              ]),
        ),
      ),
    );
  }
}
