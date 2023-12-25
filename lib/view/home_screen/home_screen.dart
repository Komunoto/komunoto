import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komunoto/custom/color.dart';
import 'package:komunoto/view/home_screen/beranda_page.dart';
import 'package:komunoto/view/home_screen/profile_page..dart';
import 'package:komunoto/view/search/data_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    BerandaPage(),
    Text('Search'),
    Text('Likes'),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/icon/icon_komunoto.png',
              fit: BoxFit.contain,
              height: 60,
              width: 100,
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset('assets/icon_topbar/icon_search.svg',colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          IconButton(
            icon: SvgPicture.asset('assets/icon_topbar/icon_notification.svg',colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
            onPressed: () {
              // Handle notification icon press
            },
          ),
          IconButton(
            icon:SvgPicture.asset('assets/icon_topbar/icon_cart.svg',colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icon_navigation/icon_home.svg',colorFilter: _selectedIndex == 0 ? const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn) : const ColorFilter.mode(Colors.black, BlendMode.srcIn),),
              label: 'Beranda'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icon_navigation/icon_toko.svg',colorFilter: _selectedIndex == 1 ? const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn) : const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
            label: 'Toko',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icon_navigation/icon_bengkel.svg', colorFilter: _selectedIndex == 2 ? const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn) : const ColorFilter.mode(Colors.black, BlendMode.srcIn) ),
            label: 'Bengkel',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icon_navigation/icon_profile.svg',colorFilter: _selectedIndex == 3 ? const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn) : const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppColors.primaryColor,
        selectedLabelStyle:  GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
         // color when selected
        unselectedLabelStyle:  GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        onTap: _onItemTapped,
      ),
    );
  }
}
