import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quizzy/screens/quiz/result_screen.dart';
import 'package:quizzy/screens/shared_screen.dart';
import 'package:quizzy/services/db_service.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  DatabaseService databaseService = DatabaseService();
  List<dynamic> myAnswer = [];
  List<dynamic> shuffledOptions = [];
  int index = 0;
  List<dynamic> questions = Get.arguments[0];
  String title = Get.arguments[1];
  int duration = int.parse(Get.arguments[2]) * 60;
  bool fromDB = Get.arguments[3];
  bool response = Get.arguments[4];
  late Timer timer;

  nextQuestion() {
    if (index < questions.length - 1) {
      setState(() {
        index += 1;
      });
    }
  }

  previousQuestion() {
    if (index > 0) {
      setState(() {
        index -= 1;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shuffling();
    quizTimer();
  }

  shuffling() {
    List<String> temp = [];
    for (int i = 0; i < questions.length; i++) {
      myAnswer.add(-1);
      temp = List.from(questions[i]['options']);
      temp.shuffle();
      shuffledOptions.add(temp);
    }
    print(myAnswer);
  }

  addResult() async {
    try {
      int score = 0;
      for (int i = 0; i < myAnswer.length; i++) {
        if (myAnswer[i] != -1) {
          if (questions[i]["options"][0] == shuffledOptions[i][myAnswer[i]]) score++;
        }
      }
      if (fromDB == false) {
        await databaseService.addQuizResult(title, myAnswer, shuffledOptions, score);
      } else if (response == true && duration != 0) {
        await databaseService.addResponse(Get.arguments[5], title, score, Get.arguments[6]);
      }
    } catch (e) {
      print(e);
    }
  }

  quizTimer() {
    timer = Timer(const Duration(seconds: 1), () {
      if (duration != 0) {
        setState(() {
          duration--;
        });
        quizTimer();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Row(
              children: [
                const Text("Time Left"),
                SizedBox(width: Get.size.width * .01),
                Text("${duration ~/ 60} min ${duration % 60} sec"),
                SizedBox(width: Get.size.width * 0.01),
              ],
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                questions[index]['question'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: Get.size.height * .04),
              Expanded(
                child: ListView.builder(
                  itemCount: shuffledOptions[index].length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              myAnswer[index] = i;
                            });
                            print(myAnswer);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(Get.size.width, Get.size.height * 0.08),
                            backgroundColor: myAnswer[index] == i
                                ? Colors.tealAccent.shade100
                                : Colors.transparent,
                          ),
                          child: Text(
                            shuffledOptions[index][i].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: Get.size.height * .02),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: Get.size.height * .02),
              Row(
                children: [
                  // if(index != 0 || index != questions.length-1)
                  // const Spacer(),
                  if (index != 0)
                    ElevatedButton.icon(
                      onPressed: previousQuestion,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(Get.size.width * 0.4, Get.size.height * 0.05),
                      ),
                      label: const Text("Previous"),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  const Expanded(child: Row()),
                  if (index != questions.length - 1)
                    ElevatedButton.icon(
                      onPressed: nextQuestion,
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(Get.size.width * 0.4, Get.size.height * 0.05)),
                      label: const Text("Next"),
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  if (index == questions.length - 1)
                    ElevatedButton(
                      onPressed: () async {
                        print("A");
                        await addResult();
                        if (fromDB == false) {
                          Get.off(const ResultScreen(),
                              arguments: [questions, shuffledOptions, myAnswer]);
                        } else {
                          if (response && duration > 0) {
                            Get.defaultDialog(
                                title: "Response is submitted",
                                // middleText: "The owner stopped accepting response or time out",
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.offAll(const SharedScreen());
                                    },
                                    child: const Text("OK"),
                                  ),
                                ]);
                          } else {
                            Get.defaultDialog(
                                title: "Response not Submitted",
                                middleText: "The owner stopped accepting response or time out",
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.offAll(const SharedScreen());
                                    },
                                    child: const Text("OK"),
                                  ),
                                ]);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(Get.size.width * 0.4, Get.size.height * 0.05),
                      ),
                      child: const Text("Finish"),
                    )
                  // if(index != 0 || index != questions.length-1)
                  // const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
