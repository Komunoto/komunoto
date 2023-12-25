import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:komunoto/function/function_get.dart';
import 'package:komunoto/global/env.dart';

class BerandaController {
  ValueNotifier<User?> userNotifier = ValueNotifier<User?>(null);
  String? image;
  String? title;
  String? description;
  String? phoneNumber;
  String? token;

  BerandaController(
      {this.image, this.title, this.description, this.phoneNumber});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> getUserData() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      userNotifier.value = currentUser;
    }
  }

  //function to get data from shared preferences
  Future<void> initializeToken() async {
    Map<String, String?> tokenAndId = await getToken();
    token = tokenAndId['token'];
    // Now you can use the token in your BerandaPage
  }

  //function to get data from api get profile user
  Future<Map<String, dynamic>> fetchUserData() async {
    if (token == null) {
      throw Exception('Token is null');
    }

    var data = await getDataUser(token!); 
    return data;
  }

  final List<Map<String, String>> dataList = [
    {'title': 'Jenis Kendaraan', 'content': '-'},
    {'title': 'Nomor Plat', 'content': '-'},
    {'title': 'Terakhir Servis', 'content': '-'},
  ];

  final List<Map<String, String>> listCommunity = [
    {
      'title': 'Honda Civic Indonesia',
      'imageUrl': 'assets/png/community.png',
      'icon': 'assets/svg/icon_verified.svg',
    },
    {
      'title': 'Toyota Indonesia',
      'imageUrl': 'assets/png/community.png',
      'icon': 'assets/svg/icon_verified.svg',
    },
    {
      'title': 'BMW Car Indonesia',
      'imageUrl': 'assets/png/community.png',
      'icon': 'assets/svg/icon_rekomendasi.svg',
    },
    {
      'title': 'Harley Davidson Indonesia',
      'imageUrl': 'assets/png/community.png',
      'icon': 'assets/svg/icon_rekomendasi.svg',
    },
    {
      'title': 'Dahaitsu Indonesia',
      'imageUrl': 'assets/png/community.png',
      'icon': 'assets/svg/icon_rekomendasi.svg',
    },
    // Add more communities as needed...
  ];
}

List<BerandaController> contents = [
  BerandaController(
    image: 'assets/png/slider_event.png',
    title: 'Welcome to Komunoto',
    description: 'Sahabat Otomotif Terbaik Anda!',
  ),
  BerandaController(
    image: 'assets/png/slider_event.png',
    description: 'Terhubung dengan sesama penggemar otomotif',
  ),
  BerandaController(
    image: 'assets/png/slider_event.png',
    description: 'Temukan bengkel dan produk otomotif yang anda butuhkan!',
  ),
];
