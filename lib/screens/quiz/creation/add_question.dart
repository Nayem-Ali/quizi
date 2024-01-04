import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quizzy/screens/home_screen.dart';
import 'package:quizzy/screens/shared_screen.dart';
import 'package:quizzy/services/db_service.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  DatabaseService databaseService = DatabaseService();
  List<Map<String, dynamic>> questions = [];

  List<TextEditingController> question = [TextEditingController()];
  List<TextEditingController> option1 = [TextEditingController()];
  List<TextEditingController> option2 = [TextEditingController()];
  List<TextEditingController> option3 = [TextEditingController()];
  List<TextEditingController> option4 = [TextEditingController()];

  final formKey = GlobalKey<FormState>();

  int index = 0;

  addQuestion() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> Q = {
        "question": question[index].text,
        "options": [
          option1[index].text,
          option2[index].text,
          if (option3[index].text.isNotEmpty) option3[index].text,
          if (option3[index].text.isNotEmpty) option4[index].text,
        ]
      };
      if (questions.isNotEmpty) {
        if (questions[index - 1]['question'] != question[index].text) {
          questions.add(Q);
        }
      } else {
        questions.add(Q);
      }
      print(questions);

      setState(() {
        question.add(TextEditingController());
        option1.add(TextEditingController());
        option2.add(TextEditingController());
        option3.add(TextEditingController());
        option4.add(TextEditingController());
        index += 1;
      });
    }
    // else{
    //   Get.defaultDialog(
    //     title: "OOPS",
    //     middleText: "Question, Option 1 and 2 is mandatory to add"
    //   );
    // }
  }

  removeQuestion() {
    print(index);
    print(question.length);
    if (index > 0 && question.isNotEmpty) {
      question[index].clear();
      question[index].dispose();
      question.removeAt(index);

      option1[index].clear();
      option1[index].dispose();
      option1.removeAt(index);

      option2[index].clear();
      option2[index].dispose();
      option2.removeAt(index);

      option3[index].clear();
      option3[index].dispose();
      option3.removeAt(index);
    }
    if (questions.length - 1 == index) {
      questions.removeAt(index);
    }
    previousQuestion();
  }

  previousQuestion() {
    setState(() {
      if (index > 0) {
        index -= 1;
      }
    });
  }

  nextQuestion() {
    setState(() {
      if (index < question.length - 1) {
        index += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question - ${index + 1}"),
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
                  controller: question[index],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Add quiz question";
                    }
                    return null;
                  },
                  maxLines: null,
                  minLines: null,
                  decoration: InputDecoration(
                    label: Text("Question - ${index + 1}"),
                    border: const OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: Get.size.height * .015),
                TextFormField(
                  controller: option1[index],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Option - 1 is mandatory";
                    }
                    return null;
                  },
                  maxLines: null,
                  minLines: null,
                  decoration: const InputDecoration(
                    label: Text("Option - 1"),
                    helperText: "Put correct answer at option 1. It will be shuffled later.",
                    helperStyle:
                        TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: Get.size.height * .015),
                TextFormField(
                  controller: option2[index],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Option - 2 is mandatory";
                    }
                    return null;
                  },
                  maxLines: null,
                  minLines: null,
                  decoration: const InputDecoration(
                    label: Text("Option - 2"),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: Get.size.height * .015),
                TextFormField(
                  controller: option3[index],
                  maxLines: null,
                  minLines: null,
                  decoration: const InputDecoration(
                    label: Text("Option - 3"),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: Get.size.height * .015),
                TextFormField(
                  controller: option4[index],
                  maxLines: null,
                  minLines: null,
                  decoration: const InputDecoration(
                    label: Text("Option - 4"),
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: previousQuestion,
                      child: const Text("Previous Question"),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: nextQuestion,
                      child: const Text("Next Question"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: removeQuestion,
                      child: const Text("Remove Question"),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: addQuestion,
                      child: const Text("ADD Question"),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    String title = Get.arguments[0];
                    String password = Get.arguments[1];
                    String duration = Get.arguments[2];
                    bool requiredID = Get.arguments[3];
                    await databaseService.addQuiz(
                      title,
                      password,
                      duration,
                      requiredID,
                      questions,
                    );
                    Get.off(const SharedScreen());
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(Get.size.width, 40)),
                  child: const Text("Create"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
