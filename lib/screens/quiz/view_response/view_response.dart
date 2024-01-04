import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quizzy/services/db_service.dart';

class ViewResponse extends StatefulWidget {
  const ViewResponse({Key? key}) : super(key: key);

  @override
  State<ViewResponse> createState() => _ViewResponseState();
}

class _ViewResponseState extends State<ViewResponse> {
  DatabaseService databaseService = DatabaseService();
  String title = Get.arguments;
  Map<String, dynamic>? data = {};
  List<dynamic> ID = [];
  List<dynamic> mark = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResponse();
  }

  getResponse() async {
    data = await databaseService.getResponse(title);
    data!.remove('marks');
    final listData = data!.entries.toList();
    listData.sort((a, b) => b.value.compareTo(a.value));
    data = Map.fromEntries(listData);
    ID = data!.entries.map((entry) => (entry.key)).toList();
    mark = data!.entries.map((entry) => (entry.value)).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Response"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: ID.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text("${index + 1}")),
            title: Text(ID[index].toString().toUpperCase()),
            trailing: Text(mark[index].toString()),
          );
        },
      ),
    );
  }
}
