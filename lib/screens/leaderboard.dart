import 'package:flutter/material.dart';
import 'package:quizzy/services/db_service.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  DatabaseService databaseService = DatabaseService();
  dynamic leaderboardResult = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    leaderboardResult = await databaseService.leaderboard();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: leaderboardResult.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent,
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                leaderboardResult[index].key.toString(),
              ),
              trailing: Text("Score: ${leaderboardResult[index].value.toStringAsFixed(0)}"),
            ),
          );
        },
      ),
    );
  }
}
