import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy/data/question_brain.dart';
import 'package:quizzy/screens/quiz/result_screen.dart';
import 'package:quizzy/screens/quiz/view/view_my_quiz.dart';
import 'package:quizzy/services/auth_services.dart';
import 'package:quizzy/services/db_service.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthServices authServices = AuthServices();
  DatabaseService databaseService = DatabaseService();

  String userName = "";
  List<dynamic> myHistory = [];
  List<dynamic> myQuiz = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    userName = await databaseService.getUserData();
    myHistory = await databaseService.getMyHistory();
    myQuiz = await databaseService.getMyQuiz();
    setState(() {});
  }

  getSummary(int index) {
    // print(myHistory[index]["title"]);
    // print(myHistory[index]["shuffledOptions"]);
    Question question = Question();
    late List<dynamic> questions;
    List<dynamic> shuffledOptions = [];
    for (int i = 0; i < myHistory[index]["shuffledOptions"].length; i++) {
      // print(myHistory[index]["shuffledOptions"]["$i"]);
      shuffledOptions.add(myHistory[index]["shuffledOptions"]["$i"]);
    }
    if (myHistory[index]["title"] == "Flutter") {
      questions = List.from(question.flutterQuestion);
    } else if (myHistory[index]["title"] == "C Programming") {
      questions = List.from(question.cQuestion);
    } else if (myHistory[index]["title"] == "Data Structure") {
      questions = List.from(question.dataStructureQuestion);
    } else if (myHistory[index]["title"] == "Python") {
      questions = List.from(question.pythonQuestion);
    } else if (myHistory[index]["title"] == "DBMS") {
      questions = List.from(question.dbmsQuestion);
    } else if (myHistory[index]["title"] == "OOP") {
      questions = List.from(question.oopQuestion);
    } else if (myHistory[index]["title"] == "Computer Network") {
      questions = question.cnQuestion;
    }

    Get.to(const ResultScreen(),
        arguments: [questions, shuffledOptions, myHistory[index]["answers"]]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userName != ""
          ? Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    radius: 50,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Center(
                          child: Text(
                            userName[0],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.size.height * 0.1,
                                color: Colors.white),
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          right: -10,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  userName,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
                ),
                const Divider(thickness: 2, color: Colors.deepPurpleAccent),
                SizedBox(
                  width: Get.size.width,
                  // color: Colors.tealAccent,
                  child: const Center(
                    child: Text(
                      "My Participation",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
                    ),
                  ),
                ),
                const Divider(thickness: 2, color: Colors.deepPurpleAccent),
                Expanded(
                  child: myHistory.isNotEmpty
                      ? ListView.builder(
                          itemCount: myHistory.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                getSummary(index);
                              },
                              child: Card(
                                color: index % 2 == 0
                                    ? Colors.limeAccent.shade100
                                    : Colors.tealAccent.shade100,
                                child: ListTile(
                                  title: Text(myHistory[index]["title"]),
                                  trailing: Text("Score: ${myHistory[index]["score"]}"),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text("No yet participate in any quiz"),
                        ),
                ),
                const Divider(thickness: 2, color: Colors.deepPurpleAccent),
                SizedBox(
                  width: Get.size.width,
                  // color: Colors.tealAccent,
                  child: const Center(
                    child: Text(
                      "My Quiz",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
                    ),
                  ),
                ),
                const Divider(thickness: 2, color: Colors.deepPurpleAccent),
                Expanded(
                  child: myQuiz.isNotEmpty
                      ? ListView.builder(
                          itemCount: myQuiz.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(const ViewMyQuiz(), arguments: myQuiz[index]);
                              },
                              child: Card(
                                color: index % 2 == 1
                                    ? Colors.limeAccent.shade100
                                    : Colors.tealAccent.shade100,
                                child: ListTile(
                                  title: Text(myQuiz[index]["title"]),
                                  // subtitle: Text("Password: ${myQuiz[index]["password"]}"),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await Share.share(
                                        "To join quiz, please enter creator ID, title and "
                                        "password in respective fields\n"
                                        "Creator ID: ${authServices.auth.currentUser!.uid}"
                                        "\nTitle: ${myQuiz[index]["title"]}"
                                        "\nPassword: ${myQuiz[index]["password"]}",
                                        subject: "QuiZi",
                                      );
                                    },
                                    icon: const Icon(Icons.share),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text("No quiz created"),
                        ),
                ),
              ],
            )
          : const Center(
              child: Text("Loading...."),
            ),
    );
  }
}
