import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komunoto/controller/beranda_controller.dart';
import 'package:komunoto/controller/profile_controller.dart';
import 'package:komunoto/custom/color.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  final BerandaController berandaController = BerandaController();
  final ProfileController profileController = ProfileController();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await berandaController.initializeToken();
    userData = await berandaController.fetchUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double size = MediaQuery.of(context).size.width * 0.15;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Ubah Profil',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18 * width / 360,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 11),
            child: Center(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icon_navigation/icon_profile.svg',
                        colorFilter: const ColorFilter.mode(
                            Colors.grey, BlendMode.srcIn),
                        height: size * 0.8,
                        width: size * 0.8,
                      ),
                    ),
                  ),
                  Container(
                    width: size, // responsive width
                    height: size, // responsive height
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor, // set border color
                        width: 5.0, // set border width
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: size / 2,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async  {
               print(userData);
              // Handle notification icon press
            },
            child: Center(
              child: Text(
                'Ubah Foto Profil',
                style: GoogleFonts.poppins(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14 * width / 360,
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 18), child: Divider()),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 18, 15, 18),
            child:
            Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Info Profil',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14 * width / 360,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.info_outline_rounded,
                        color: Colors.black,
                        size: 14 * width / 360,
                      )
                    ],
                  ),
                  Table(
                    columnWidths: const {
                      0: FractionColumnWidth(
                          .45), // Column 1 is 30% of the total width
                      1: FractionColumnWidth(
                          .5), // Column 2 is 50% of the total width
                      2: FractionColumnWidth(
                          .05), // Column 3 is 20% of the total width
                    }, // Set the width to the desired value
                    children:  [
                      TableRow(
                        children: [
                          Text('Nama Depan', style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),),
                          Text(userData?['firstName'] ?? 'Gak Ada', style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),),
                           InkWell(
                            onTap: (){

                            },
                            child: Icon(Icons.arrow_forward_ios_rounded)),
                          // Add more Text widgets for more columns
                        ],
                      ),
                    ],
                  ),
                  Table(
                    columnWidths: const {
                      0: FractionColumnWidth(
                          .45), // Column 1 is 30% of the total width
                      1: FractionColumnWidth(
                          .5), // Column 2 is 50% of the total width
                      2: FractionColumnWidth(
                          .05), // Column 3 is 20% of the total width
                    }, // Set the width to the desired value
                    children:  [
                      TableRow(
                        children: [
                          Text('Nama Belakang', style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),),
                          Text(userData?['lastName'] ?? 'Gak Ada', style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),),
                          InkWell(
                            onTap: (){

                            },
                            child: Icon(Icons.arrow_forward_ios_rounded)),
                          // Add more Text widgets for more columns
                        ],
                      ),
                    ],
                  ),
                ],
              )
          )
        ],
      )),
    );
  }
}
