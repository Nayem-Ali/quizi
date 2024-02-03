import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  addUserInfo(String uid, String name) async {
    await fireStore.collection("user").doc(uid).set({
      "uid": uid,
      "name": name,
    });
    await fireStore.collection("leaderboard").doc(uid).set({
      "Flutter": 0,
      "C Programming": 0,
      "Data Structure": 0,
      "Python": 0,
      "DBMS": 0,
      "OOP": 0,
      "Computer Network": 0,
    });
  }

  getUserData() async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    String? userName;
    await fireStore.collection("user").doc(userID).get().then((value) {
      userName = value["name"];
    });
    return userName;
  }

  addQuizResult(
    String docName,
    List<dynamic> myAnswer,
    List<dynamic> shuffledOptions,
    int score,
  ) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
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

  getMyParticipation() async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    List<dynamic> data = [];
    QuerySnapshot querySnapshot =
        await fireStore.collection("user").doc(userID).collection("Result").get();
    data = querySnapshot.docs.map((docs) => docs.data()).toList();
    return data;
  }

  leaderboard() async {
    ///leader board all data will store in data list
    List<dynamic> data = [];
    /// user data will be stored in userData list
    List<dynamic> userData = [];
    Map<String, double> leaderboardData = {};
    QuerySnapshot querySnapshot1 = await fireStore.collection("leaderboard").get();
    QuerySnapshot querySnapshot2 = await fireStore.collection("user").get();
    data = querySnapshot1.docs.map((docs) => docs.data()).toList();
    userData = querySnapshot2.docs.map((docs) => docs.data()).toList();

    for (int i = 0; i < data.length; i++) {
      double score = 0;
      Map<String, dynamic> myScore = data[i];
      print(myScore);
      myScore.forEach((key, value) {
        score += value;
      });
      print("${userData[i]['name']} - $score");
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
    String userID = FirebaseAuth.instance.currentUser!.uid;

    await fireStore.collection("user").doc(userID).collection("myQuiz").doc(title).set({
      "title": title,
      "password": pass,
      "duration": duration,
      "requiredID": requiredID,
      "accept": true,
      "questions": questions,
    });
    await fireStore
        .collection("user")
        .doc(userID)
        .collection("Response")
        .doc(title)
        .set({"marks": questions.length});
  }

  updateQuizDetails(String title, String key, bool value) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await fireStore.collection("user").doc(userID).collection("myQuiz").doc(title).update(
      {key: value},
    );
  }

  getMyQuiz() async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    List<dynamic> data = [];
    QuerySnapshot querySnapshot =
        await fireStore.collection("user").doc(userID).collection("myQuiz").get();
    data = querySnapshot.docs.map((docs) => docs.data()).toList();
    return data;
  }

  joinQuiz(String creatorID, String title, String password) async {
    try {
      dynamic data =
          await fireStore.collection('user').doc(creatorID).collection('myQuiz').doc(title).get();
      if (data['password'] == password) {
        return data;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  addResponse(String creatorID, String title, int score, String studentID) async {
    await fireStore
        .collection('user')
        .doc(creatorID)
        .collection('Response')
        .doc(title)
        .update({studentID: score});
  }

  getResponse(String title) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic>? data;
    await fireStore
        .collection("user")
        .doc(userID)
        .collection("Response")
        .doc(title)
        .get()
        .then((value) {
      data = value.data();
    });
    return data;
  }
}

// To join quiz, please enter creator ID, title and password in respective fields
// Creator ID: Go9QSZ7VJfS3HenaboEXYUO1BR72
// Title: Basic Math
// Password: math123