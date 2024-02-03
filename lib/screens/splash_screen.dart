import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzy/screens/home_screen.dart';
import 'package:quizzy/screens/shared_screen.dart';

import '../utility/logo.dart';
import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Logo(fontSize: 32, width: 300, height: 300),
      splashIconSize: 400,
      duration: 10000,
      nextScreen: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const LoginScreen();
            } else if(snapshot.hasData) {
              return const SharedScreen();
            }
            else {
              return const LoginScreen();
            }
          }),
    );
  }
}
