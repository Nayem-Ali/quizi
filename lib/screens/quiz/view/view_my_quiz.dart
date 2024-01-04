import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy/screens/quiz/view_response/view_response.dart';
import 'package:quizzy/services/db_service.dart';

class ViewMyQuiz extends StatefulWidget {
  const ViewMyQuiz({Key? key}) : super(key: key);

  @override
  State<ViewMyQuiz> createState() => _ViewMyQuizState();
}

class _ViewMyQuizState extends State<ViewMyQuiz> {
  DatabaseService databaseService = DatabaseService();
  dynamic data = Get.arguments;
  dynamic questions = Get.arguments['questions'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${data['title']}'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Get.to(const ViewResponse(), arguments: data['title']);
          }, icon: const Icon(Icons.list))
        ],
      ),
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          children: [
            const Divider(thickness: 1, color: Colors.deepPurpleAccent),
            const Text(
              'Quiz Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(thickness: 1, color: Colors.deepPurpleAccent),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Duration ${data['duration']} minutes',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                // textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: Get.size.height * 0.01),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Password: ${data['password']}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                // textAlign: TextAlign.start,
              ),
            ),
            // SizedBox(height: Get.size.height*0.01),
            Row(
              children: [
                const Text(
                  'Required Student ID',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  activeColor: Colors.green,
                  value: data['requiredID'],
                  onChanged: (value) async {
                    setState(() {
                      data['requiredID'] = value;
                    });
                    await databaseService.updateQuizDetails(data['title'], "requiredID", value);
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Accept Response',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  activeColor: Colors.green,
                  value: data['accept'],
                  onChanged: (value) async {
                    setState(() {
                      data['accept'] = value;
                    });
                    await databaseService.updateQuizDetails(data['title'], "accept", value);
                  },
                ),
              ],
            ),
            // SizedBox(height: Get.size.height * 0.05),
            const Divider(thickness: 1, color: Colors.deepPurpleAccent),
            const Text(
              'Quiz Question',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(thickness: 1, color: Colors.deepPurpleAccent),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(
                        "Q${index + 1}. ${questions[index]['question']}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "1. ${questions[index]['options'][0]}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "2. ${questions[index]['options'][1]}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      if (questions[index]['options'].length > 2)
                        Text(
                          "3. ${questions[index]['options'][2]}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (questions[index]['options'].length > 3)
                        Text(
                          "4. ${questions[index]['options'][3]}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const Divider(),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: questions[index]['options'].length,
                      //     itemBuilder: (context, i) {
                      //       return Text(questions[index]['options'][i]);
                      //     },
                      //   ),
                      // )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
