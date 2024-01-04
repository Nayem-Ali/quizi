import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../screens/auth/login_screen.dart';
import '../utility/logo.dart';

class AuthServices {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  addUserInfo(String uid, String name) async {
    await fireStore.collection("user").doc(uid).set({
      "uid": uid,
      "name": name,
    });
    await fireStore.collection("leaderboard").doc(uid).set({
      "Flutter": 0,
      "C Programming": 0,
      "Data Structure": 0,
      "Python": 0,
      "DBMS": 0,
      "OOP": 0,
      "Computer Network": 0,
    });
  }

  registerUser(String email, String password, String name, BuildContext context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userInfo) async {
        await userInfo.user?.sendEmailVerification().whenComplete(() {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Email verification message is sent"),
                content: Text(
                    "To login with your account please verify your email ${userInfo.user!.email} first."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK")),
                ],
              );
            },
          );
        });
        await addUserInfo(userInfo.user!.uid, name);
      });
    } on FirebaseException catch (e) {
      Get.defaultDialog(
        title: "Something went wrong",
        middleText: e.message!,
        middleTextStyle: const TextStyle(
          color: Colors.red,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("OK"),
          ),
        ],
      );
    }
  }

  Future<String> loginUser(String email, String password) async {
    String message = "";
    try {
      await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        if (value.user!.emailVerified) {
          message = "true";
          return message;
        } else {
          await value.user?.sendEmailVerification().whenComplete(() {});

          message = "Verification email sent $email";
          return message;
        }
      });
    } on FirebaseException catch (e) {
      message = e.message!;
    }
    return message;
  }

  logOutUser() {
    Get.defaultDialog(title: "Alert", middleText: "Are you sure to logout?", actions: [
      TextButton(
          onPressed: () async {
            await auth.signOut().whenComplete(() {
              Get.offAll(const LoginScreen());
            });
          },
          child: const Text("Yes")),
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("No")),
    ]);
  }

  forgetPassword() {
    TextEditingController emailController = TextEditingController();
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            children: [
              const Logo(
                width: 80,
                height: 80,
                fontSize: 10,
              ),
              SizedBox(height: Get.size.height * 0.02),
              const Text(
                "Enter email and tap sent button then check your email. A password reset link will "
                "be sent.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Get.size.height * 0.02),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  label: Text("Email"),
                  icon: Icon(
                    Icons.email,
                    color: Colors.deepPurpleAccent,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: Get.size.height * 0.02),
              ElevatedButton.icon(
                onPressed: () async {
                  await auth.sendPasswordResetEmail(email: emailController.text.trim());
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.size.width * 0.8, Get.size.height * 0.08)),
                label: const Text(
                  "Sent",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: const Icon(Icons.send),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
