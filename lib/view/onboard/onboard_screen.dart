import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komunoto/controller/onboard_controller.dart';
import 'package:komunoto/view/Auth/login_page.dart';
import 'package:komunoto/custom/button_login.dart';
import 'package:komunoto/custom/button_passed.dart';
import 'package:komunoto/view/home_screen/home_screen.dart';
import 'slider.dart';
import '/global/env.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;
  final OnboardController onboardController = OnboardController();

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
    onboardController.fetchOnboardData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardController.onboardData.length,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final item = onboardController.onboardData[index];
              double width = MediaQuery.of(context).size.width;
              double height = MediaQuery.of(context).size.height;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        width * 0.05, height * 0.20, width * 0.05, 0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: SvgPicture.network(
                        '$dev_url/${item['image']}',
                       
                      ),
                    ),
                  ),
                  Text(
                    item['title'] ?? '',
                    style: GoogleFonts.poppins(
                        fontSize: 30 * width / 720,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Text(
                    item['description'],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 25 * width / 720,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(contents.length,
                              (index) => buildDot(index, context, width))),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                ButtonLogin(
                  text: 'Masuk / Daftar',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonPassed(
                  text: 'Lewati',
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context, double width) {
    return Container(
      height: 7 * width / 720,
      width: currentIndex == index ? 28 * width / 720 : 10 * width / 720,
      margin: EdgeInsets.only(right: 5 * width / 720),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20 * width / 720),
          color: Colors.amber[900]),
    );
  }
}
