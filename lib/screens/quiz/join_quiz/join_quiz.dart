import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:quizzy/services/db_service.dart';

import '../question_page.dart';

class JoinQuiz extends StatefulWidget {
  const JoinQuiz({Key? key}) : super(key: key);

  @override
  State<JoinQuiz> createState() => _JoinQuizState();
}

class _JoinQuizState extends State<JoinQuiz> {
  DatabaseService databaseService = DatabaseService();
  TextEditingController creatorID = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController studentID = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();

  takeID(dynamic data) {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: formKey1,
          child: Column(
            children: [
              TextFormField(
                controller: studentID,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Student ID";
                  }
                  return null;
                },
                decoration:
                    const InputDecoration(label: Text("Student ID"), border: OutlineInputBorder()),
              ),
              ElevatedButton(
                onPressed: () {
                  if(formKey1.currentState!.validate()){
                    Get.to(const QuestionPage(), arguments: [
                      data['questions'],
                      data['title'],
                      data['duration'],
                      true,
                      data['accept'] as bool,
                      creatorID.text.trim(),
                      studentID.text.trim(),
                    ]);
                  }
                },
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join Quiz"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: creatorID,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Creator ID";
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(label: Text("Creator ID"), border: OutlineInputBorder()),
                ),
                SizedBox(height: Get.size.height * 0.02),
                TextFormField(
                  controller: title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter quiz title";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Quiz Title"),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: Get.size.height * 0.02),
                TextFormField(
                  controller: password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Quiz Password";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Quiz Password"),
                    border: OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      dynamic data = await databaseService.joinQuiz(
                        creatorID.text.trim(),
                        title.text.trim(),
                        password.text.trim(),
                      );
                      if (data['title'] == title.text.trim()) {
                        takeID(data);
                      } else {
                        Get.defaultDialog(
                            title: "Quiz not Found",
                            middleText: "Please provide correct credential",
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text('OK'),
                              ),
                            ]);
                      }
                    }
                  },
                  child: const Text("Join"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
