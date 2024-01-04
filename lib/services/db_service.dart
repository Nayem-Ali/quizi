import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String userID = FirebaseAuth.instance.currentUser!.uid;

  getUserData() async {
    String? userName;
    await fireStore.collection("user").doc(userID).get().then((value) {
      userName = value["name"];
    });
    return userName;
  }

  addQuizResult(
      String docName, List<dynamic> myAnswer, List<dynamic> shuffledOptions, int score) async {
    Map<String, dynamic> myOptions = {};
    for (int i = 0; i < shuffledOptions.length; i++) {
      myOptions["$i"] = shuffledOptions[i];
    }
    await fireStore.collection("user").doc(userID).collection("Result").doc(docName).set({
      "title": docName,
      "answers": myAnswer,
      "shuffledOptions": myOptions,
      "score": score,
    });
    await fireStore.collection("leaderboard").doc(userID).update({docName: score});
  }

  getMyHistory() async {
    List<dynamic> data = [];
    QuerySnapshot querySnapshot =
        await fireStore.collection("user").doc(userID).collection("Result").get();
    data = querySnapshot.docs.map((docs) => docs.data()).toList();
    return data;
  }

  leaderboard() async {
    List<dynamic> data = [];
    List<dynamic> userData = [];
    Map<String, double> leaderboardData = {};
    QuerySnapshot querySnapshot1 = await fireStore.collection("leaderboard").get();
    QuerySnapshot querySnapshot2 = await fireStore.collection("user").get();
    data = querySnapshot1.docs.map((docs) => docs.data()).toList();
    userData = querySnapshot2.docs.map((docs) => docs.data()).toList();

    for (int i = 0; i < data.length; i++) {
      double score = 0;
      Map<String, dynamic> myScore = data[i];
      myScore.forEach((key, value) {
        score += value;
      });
      leaderboardData[userData[i]["name"]] = score;
      // print(data[i]);
      // print(userData[i]["name"]);
    }
    List<MapEntry<String, double>> listData = leaderboardData.entries.toList();
    listData.sort((a, b) => b.value.compareTo(a.value));
    leaderboardData = Map.fromEntries(listData);
    // print(leaderboardData);
    return leaderboardData.entries.toList();
  }

  addQuiz(String title, String pass, String duration, bool requiredID,
      List<Map<String, dynamic>> questions) async {
    await fireStore.collection("user").doc(userID).collection("myQuiz").doc(title).set({
      "title": title,
      "password": pass,
      "duration": duration,
      "requiredID": requiredID,
      "accept": true,
      "questions": questions,
    });
    await fireStore.collection("user").doc(userID).collection("Response").doc(title).set({
      "marks": questions.length
    });
  }

  updateQuizDetails(String title, String key, bool value) async {
    await fireStore
        .collection("user")
        .doc(userID)
        .collection("myQuiz")
        .doc(title)
        .update({key: value});
  }

  getMyQuiz() async {
    List<dynamic> data = [];
    QuerySnapshot querySnapshot =
        await fireStore.collection("user").doc(userID).collection("myQuiz").get();
    data = querySnapshot.docs.map((docs) => docs.data()).toList();
    return data;
  }

  joinQuiz(String creatorID, String title, String password) async {
    try{
      dynamic data =
      await fireStore.collection('user').doc(creatorID).collection('myQuiz').doc(title).get();
      if(data['password'] == password) {
        return data;
      } else {
        return {};
      }
    }
    catch(e){
      return {};
    }
  }

  addResponse(String creatorID, String title, int score, String studentID) async{
    await fireStore.collection('user').doc(creatorID).collection('Response').doc(title).update(
      {
        studentID:score
      }
    );
  }


  getResponse(String title) async {
    Map<String,dynamic>? data;
    await fireStore.collection("user").doc(userID).collection
      ("Response").doc(title).get().then((value) {
        data = value.data();
    });
    return data;
  }

}
