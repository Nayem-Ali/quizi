import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:quizzy/services/db_service.dart';
import 'package:share_plus/share_plus.dart';

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
  String resultSheet = "ID - Mark\n";

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

  shareResponse() async {
    final pdf = pw.Document();
    for (int i = 0; i < ID.length; i++) {
      resultSheet += "${ID[i]} - ${mark[i]}\n";
    }
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Text(
            resultSheet,
            style: const pw.TextStyle(fontSize: 18)
          ),
        ),
      ),
    );
    final Directory directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/result.pdf');
    await file.writeAsBytes(await pdf.save());
    Share.shareXFiles([XFile(file.path)]
        // subject: "$title result",
        // "${file.openRead()}",
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Response"),
        centerTitle: true,
        actions: [IconButton(onPressed: shareResponse, icon: const Icon(Icons.share))],
      ),
      body: ListView.builder(
        itemCount: ID.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text("${index + 1}")),
              title: Text(ID[index].toString().toUpperCase()),
              trailing: Text(mark[index].toString()),
            ),
          );
        },
      ),
    );
  }
}
