import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy/screens/quiz/creation/add_question.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  TextEditingController title = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController duration = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Quiz"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Must fill with title";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Quiz Title"),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: Get.size.height * 0.015),
                TextFormField(
                  controller: password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Must fill with password";
                    } else if (value.length < 6) {
                      return "Password length must be 6 or more";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Quiz Password"),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: Get.size.height * 0.015),
                TextFormField(
                  controller: duration,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Provide a duration of quiz";
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Quiz Duration"),
                    helperText: "in minutes",
                    border: OutlineInputBorder(),
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () {
                   if(formKey.currentState!.validate()){
                     Get.to(const AddQuestion(), arguments: [
                       title.text.trim(),
                       password.text.trim(),
                       duration.text.trim(),
                       true, // studentID
                     ]);
                   }
                  },
                  label: const Text("Next"),
                  icon: const Icon(Icons.arrow_forward),
                  // style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
