import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quizzy/screens/auth/sign_up.dart';
import 'package:quizzy/screens/shared_screen.dart';
import 'package:quizzy/services/auth_services.dart';

import '../../utility/logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthServices authServices = AuthServices();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isVisible = true;

  loginFunction() async {
    String response = await authServices.loginUser(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    if (response == 'true') {
      Get.offAll(const SharedScreen());
    } else {
      Get.defaultDialog(
          title: "Something went wrong",
          middleText: response,
          titleStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                Get.back();
              },
              label: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: const Icon(
                Icons.done,
                color: Colors.red,
              ),
            ),
          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: Get.size.height,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Logo(height: 100, width: 100, fontSize: 32),
                  SizedBox(height: Get.size.height * 0.05),
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
                  SizedBox(height: Get.size.height * 0.01),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.deepPurpleAccent,
                      ),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: isVisible
                            ? const Icon(Icons.visibility_sharp)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                    obscureText: isVisible,
                  ),
                  SizedBox(height: Get.size.height * 0.01),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () async {
                        await authServices.forgetPassword();
                      },
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.size.height * 0.01),
                  ElevatedButton.icon(
                      onPressed: loginFunction,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          Get.size.width * 0.7,
                          Get.size.height * 0.08,
                        ),
                      ),
                      label: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(Icons.login)),
                  SizedBox(height: Get.size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Did not have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: Get.size.height * 0.01),
                      TextButton(
                          onPressed: () {
                            Get.off(const SignUpScreen());
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
