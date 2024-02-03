import 'package:flutter/material.dart';
import 'package:quizzy/screens/home_screen.dart';
import 'package:quizzy/screens/leaderboard.dart';
import 'package:quizzy/screens/proifle.dart';
import 'package:quizzy/services/auth_services.dart';

class SharedScreen extends StatefulWidget {
  const SharedScreen({Key? key}) : super(key: key);

  @override
  State<SharedScreen> createState() => _SharedScreenState();
}

class _SharedScreenState extends State<SharedScreen> {
  List screens = const [HomeScreen(), LeaderBoard(), ProfileScreen()];
  AuthServices authServices = AuthServices();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "QuiZi",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                await authServices.logOutUser();
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: screens[index],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (currentIndex) {
            setState(() {
              index = currentIndex;
            });
          },
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Leaderboard"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
