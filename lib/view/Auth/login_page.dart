// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:komunoto/view/Auth/auth_number_phone.dart';
import 'package:komunoto/custom/button_login_apple.dart';
import 'package:komunoto/custom/button_login_google.dart';
import 'package:komunoto/custom/button_login_sent.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userObj;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print(credential);
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String phoneNumber = '';
    // FocusNode phoneNode = FocusNode();  // ignore: unused_local_variable

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: Text(
        'Masuk / Daftar',
        style: GoogleFonts.poppins(
            fontSize: 30 * width / 720,
            fontWeight: FontWeight.w600,
            color: Colors.black),
      )),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
            key: _formkey,
            child: Stack(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: IntlPhoneField(
                      // focusNode: phoneNode,
                      decoration: InputDecoration(
                        labelText: 'Enter your phone number',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      initialCountryCode: 'ID',
                      languageCode: 'en',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                      onSaved: (phone) {
                        phoneNumber = phone!.completeNumber;
                      },
                      onCountryChanged: (country) {
                        print('Country changed to: ${country.name}');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        // Handle your tap here.
                      },
                      child: Text(
                        'Sudah daftar tapi lupa nomor HP?',
                        style: GoogleFonts.poppins(
                            fontSize: 20 * width / 720,
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  ButtonLoginSent(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        _auth.verifyPhoneNumber(
                          phoneNumber: phoneNumber,
                          timeout: const Duration(seconds: 60),
                          verificationCompleted:
                              (PhoneAuthCredential credential) async {
                            // This callback will be invoked when the verification is done automatically
                            await _auth.signInWithCredential(credential);
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            // Handle the error here
                            print('${e.message} ok');
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            // Update the UI - wait for the user to enter the SMS code
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => AuthNumberPhone(
                                      phoneNumber: phoneNumber,
                                      verificationId: verificationId,
                                    ));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {
                            // This callback will be invoked when auto retrieval times out
                            // You can use this `verificationId` to create `PhoneAuthCredential`
                          },
                        );
                      }
                    },
                    buttonText: 'Kirim',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Colors.black
                                      .withOpacity(0.15000000596046448),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Atau',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  Colors.black.withOpacity(0.30000001192092896),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 150,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Colors.black
                                      .withOpacity(0.15000000596046448),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ButtonLoginGoogle(
                      text: 'Lanjutkan dengan Google', onPressed: () {}),
                  ButtonLoginApple(
                      text: 'Lanjutkan dengan Apple', onPressed: () {}),
                ],
              ),
              Positioned(
                bottom: 30.0,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Syarat Ketentuan Berlaku',
                    style: GoogleFonts.poppins(
                      fontSize: 20 * width / 720,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
