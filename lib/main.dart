import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzy/screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// To interact with flutter engine
  await Firebase.initializeApp(
    // name: "Flutter Notifications",
    // options: const FirebaseOptions(
    //   apiKey: "AIzaSyBqjZJCKd-aGGb2TUwRFbUYAnqSbcW4KgY",
    //   appId: "1:1081574560491:android:8985e69ca15ce8155aa4ae",
    //   messagingSenderId: "1081574560491",
    //   projectId: "flutter-notifications-b949e",
    //   storageBucket: "flutter-notifications-b949e.appspot.com",
    // ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SplashScreen(),
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        primaryColor: Colors.deepPurpleAccent,
        //fontFamily: "Poppins",
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
