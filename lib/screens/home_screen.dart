import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy/data/question_brain.dart';
import 'package:quizzy/screens/quiz/creation/create_quiz.dart';
import 'package:quizzy/screens/quiz/join_quiz/join_quiz.dart';
import 'package:quizzy/screens/quiz/question_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Question question = Question();
  List<dynamic> questions = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  List<String> images = [
    "images/flutter.png",
    "images/c.png",
    "images/ds.png",
    "images/python.png",
    "images/dbms.png",
    "images/oop.png",
    "images/cn.png",
  ];
  List<String> titles = [
    "Flutter",
    "C Programming",
    "Data Structure",
    "Python",
    "DBMS",
    "OOP",
    "Computer Network",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questions.add(question.flutterQuestion);
    questions.add(question.cQuestion);
    questions.add(question.dataStructureQuestion);
    questions.add(question.pythonQuestion);
    questions.add(question.dbmsQuestion);
    questions.add(question.oopQuestion);
    questions.add(question.cnQuestion);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    height: Get.height * 0.15,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.redAccent,
                          Colors.blueAccent.shade100,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Get.to(const CreateQuiz());
                        },
                        child: Text(
                          "Create\nQuiz",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.textScaleFactor * 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    height: Get.size.height * 0.15,
                    width: Get.size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        Colors.blueAccent,
                        Colors.redAccent.shade100,
                      ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(const JoinQuiz());
                        },
                        child: Text(
                          "Join\nQuiz",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.textScaleFactor * 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 2,
                color: Colors.deepPurpleAccent.shade100,
              ),
              const Text(
                "Quiz Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),

              ),
              Divider(
                thickness: 2,
                color: Colors.deepPurpleAccent.shade100,
              ),
              Container(
                height: Get.height * 0.5,
                width: Get.width ,
                margin: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0
                  ),
                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: () {
                        Get.to(
                          const QuestionPage(),
                          arguments: [
                            questions[index], //question
                            titles[index], // title
                            "15", // duration
                            false, //  From Database
                            true, // for adding response to database
                          ],
                        );
                      },
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              titles[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.textScaleFactor * 18,
                                color: Colors.deepPurpleAccent,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Image(
                              image: AssetImage(images[index]),
                              height: Get.size.height * 0.09,
                              width: Get.size.height * 0.09,
                              fit: BoxFit.fill,
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
