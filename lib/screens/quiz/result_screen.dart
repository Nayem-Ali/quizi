import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy/services/db_service.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  DatabaseService databaseService = DatabaseService();
  List<dynamic> questions = Get.arguments[0];
  List<dynamic> shuffledOptions = Get.arguments[1];
  List<dynamic> myAnswer = Get.arguments[2];
  List<bool> result = [];
  int score = 0;

  getResult() {
    for (int i = 0; i < questions.length; i++) {
      if (myAnswer[i] == -1) {
        result.add(false);
        continue;
      }
      result.add(questions[i]['options'][0] == shuffledOptions[i][myAnswer[i]]);
      if (questions[i]['options'][0] == shuffledOptions[i][myAnswer[i]]) {
        score++;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResult();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Result"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: Get.size.height * .15,
              width: Get.size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(),
                gradient: LinearGradient(
                  colors: [Colors.deepPurpleAccent, Colors.purple.shade100],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Center(
                child: Text(
                  "You got: $score / ${questions.length}",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          questions[index]['question'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: result[index] ? Colors.green : Colors.red,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: Get.size.height * 0.03),
                        Text(
                          myAnswer[index] == -1
                              ? "Not Attempted"
                              : "Your Answer: "
                                  "${shuffledOptions[index][myAnswer[index]]}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: Get.size.height * 0.02),
                        if (result[index] == false)
                          Text(
                            "Correct Answer: ${questions[index]['options'][0]}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        if (result[index] == false) SizedBox(height: Get.size.height * 0.02),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
