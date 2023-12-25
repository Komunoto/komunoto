import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:komunoto/view/Auth/login_page.dart';
import 'package:komunoto/view/home_screen/home_screen.dart';

class AfterLogin extends StatefulWidget {
  const AfterLogin({super.key});

  @override
  State<AfterLogin> createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Komunoto Apps')),
        body: Column(
          children: <Widget>[
            const Text('Registered'),
            ElevatedButton(
              child:  const Text('Logout'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPage (),
                  ),
                );
              },
            ),
            ElevatedButton(
              child:  const Text('Logout'),
              onPressed: () async {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const HomeScreen (),
                  ),
                );
              },
            ),
          
            // Text(user!.uid),
            // Text(user!.displayName!),
            // Text(user!.email!),
            // Image.network(user!.photoURL.toString()),
          ],
        ));
  }
}
