import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komunoto/controller/beranda_controller.dart';
import 'package:komunoto/controller/profile_controller.dart';
import 'package:komunoto/custom/color.dart';
import 'package:komunoto/view/home_screen/home_screen.dart';
import 'package:komunoto/view/profile/view_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController profileController = ProfileController();
  final BerandaController berandaController = BerandaController();
  int? progress;
  @override
  void initState() {
    super.initState();
    profileController.getUserData();
    fetchData();
  }

  Future<void> fetchData() async {
    await berandaController.initializeToken();
    Map<String, dynamic> userData = await berandaController.fetchUserData();
    progress = int.parse(userData['progress']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = MediaQuery.of(context).size.width * 0.15;
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ValueListenableBuilder(
          valueListenable: profileController.userNotifier,
          builder: (BuildContext context, User? user, Widget? child) {
            if (user != null) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: user.photoURL != null
                                          ? Image.network(
                                              user.photoURL!,
                                              height: size * 0.8,
                                              width: size * 0.8,
                                            )
                                          : SvgPicture.asset(
                                              'assets/icon_navigation/icon_profile.svg',
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      Colors.grey,
                                                      BlendMode.srcIn),
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
                                        color: AppColors
                                            .primaryColor, // set border color
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
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Halo,',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      user.displayName != null
                                          ? user.displayName!
                                          : user.phoneNumber!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    if (progress != 100)
                                      Row(
                                        children: [
                                          Text(
                                            'Lengkapi Profil Anda',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontSize: 5 / width * 720,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 0.1 * width,
                                          ),
                                          SizedBox(
                                            width: 0.2 * width,
                                            height: 0.01 * height,
                                            child: LinearProgressIndicator(
                                              value: (progress ?? 0) / 100,
                                              backgroundColor: Colors.grey[200],
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ViewProfile()));
                            },
                            child: const Icon(Icons.edit_outlined,
                                color: AppColors.primaryColor),
                          ),
                        ]),
                    SizedBox(
                      height: 28 * height / 1280,
                    ),
                    Text(
                      'Aktivitas Saya',
                      style: GoogleFonts.poppins(
                        fontSize: 26 * width / 720,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20 * height / 1280,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                            'assets/icon_navigation/icon_bengkel.svg',
                            height: 16,
                            width: 16,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn)),
                        SizedBox(
                          width: 14 * width / 720,
                        ),
                        Text(
                          'Garasi',
                          style: GoogleFonts.poppins(
                            fontSize: 20 * width / 720,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20 * height / 1280,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                            'assets/icon_navigation/icon_komunitas.svg',
                            height: 16,
                            width: 16,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn)),
                        SizedBox(
                          width: 14 * width / 720,
                        ),
                        Text(
                          'Komunitasku',
                          style: GoogleFonts.poppins(
                            fontSize: 20 * width / 720,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20 * height / 1280,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/svg/icon_kegiatan.svg',
                            height: 16,
                            width: 16,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn)),
                        SizedBox(
                          width: 14 * width / 720,
                        ),
                        Text(
                          'Kegiatan',
                          style: GoogleFonts.poppins(
                            fontSize: 20 * width / 720,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20 * height / 1280,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                            'assets/svg/icon_riwayat_transaksi.svg',
                            height: 16,
                            width: 16,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn)),
                        SizedBox(
                          width: 14 * width / 720,
                        ),
                        Text(
                          'Riwayat Transaksi',
                          style: GoogleFonts.poppins(
                            fontSize: 20 * width / 720,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 28 * height / 1280,
                    ),
                    Text(
                      'General',
                      style: GoogleFonts.poppins(
                        fontSize: 26 * width / 720,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20 * height / 1280,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/svg/icon_syarat_ketentuan.svg',
                            height: 16,
                            width: 16,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn)),
                        SizedBox(
                          width: 14 * width / 720,
                        ),
                        Text(
                          'Syarat dan Ketentuan',
                          style: GoogleFonts.poppins(
                            fontSize: 20 * width / 720,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20 * height / 1280,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/svg/icon_bantuan.svg',
                            height: 16,
                            width: 16,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn)),
                        SizedBox(
                          width: 14 * width / 720,
                        ),
                        Text(
                          'Bantuan',
                          style: GoogleFonts.poppins(
                            fontSize: 20 * width / 720,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20 * height / 1280,
                    ),
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg/icon_logout.svg',
                              height: 16,
                              width: 16,
                              colorFilter: const ColorFilter.mode(
                                  Colors.black, BlendMode.srcIn)),
                          SizedBox(
                            width: 14 * width / 720,
                          ),
                          Text(
                            'Keluar',
                            style: GoogleFonts.poppins(
                              fontSize: 20 * width / 720,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]);
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
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
                                color:
                                    AppColors.primaryColor, // set border color
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Masuk/Daftar',
                              style: GoogleFonts.poppins(
                                fontSize: 25 * width / 720,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Bergabung dengan komunoto sekarang!',
                              style: GoogleFonts.poppins(
                                fontSize: 18 * width / 720,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 28 * height / 1280,
                  ),
                  Text(
                    'General',
                    style: GoogleFonts.poppins(
                      fontSize: 26 * width / 720,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20 * height / 1280,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/icon_syarat_ketentuan.svg',
                          height: 16,
                          width: 16,
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn)),
                      SizedBox(
                        width: 14 * width / 720,
                      ),
                      Text(
                        'Syarat dan Ketentuan',
                        style: GoogleFonts.poppins(
                          fontSize: 20 * width / 720,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20 * height / 1280,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/icon_bantuan.svg',
                          height: 16,
                          width: 16,
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn)),
                      SizedBox(
                        width: 14 * width / 720,
                      ),
                      Text(
                        'Bantuan',
                        style: GoogleFonts.poppins(
                          fontSize: 20 * width / 720,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      )),
    );
  }
}
