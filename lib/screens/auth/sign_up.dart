import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quizzy/screens/auth/login_screen.dart';
import 'package:quizzy/services/auth_services.dart';

import '../../utility/logo.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthServices authServices = AuthServices();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final fullNameRegex = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$');

  final formKey = GlobalKey<FormState>();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: Get.size.height,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Logo(height: 100, width: 100, fontSize: 32),
                    SizedBox(height: Get.size.height * 0.05),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your name";
                        } else if (fullNameRegex.hasMatch(value) == false) {
                          return "Please enter valid name eg. Nabil Rahman Razy, Fariha-Tasnim";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("Name"),
                        icon: Icon(
                          Icons.drive_file_rename_outline,
                          color: Colors.deepPurpleAccent,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: Get.size.height * 0.01),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        } else if (emailRegex.hasMatch(value) == false) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        } else if (value.length < 6) {
                          return "Password must be 6 characters long";
                        }
                        return null;
                      },
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
                    TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please re-enter your password";
                        } else if (value != passwordController.text.trim()) {
                          return "Password doesn't match";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("Re-type Password"),
                        icon: Icon(
                          Icons.lock,
                          color: Colors.deepPurpleAccent,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: isVisible,
                    ),
                    SizedBox(height: Get.size.height * 0.04),
                    ElevatedButton.icon(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await authServices.registerUser(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              nameController.text.trim(),
                              context,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(Get.size.width * 0.7, Get.size.height * 0.08)),
                        label: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        icon: const Icon(
                          Icons.create,
                        )),
                    SizedBox(height: Get.size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: Get.size.height * 0.01),
                        TextButton(
                            onPressed: () {
                              Get.off(const LoginScreen());
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
