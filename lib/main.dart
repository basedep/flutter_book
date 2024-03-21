import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import "dart:io";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import "notes/Notes.dart";
import "utils.dart" as utils;

void main() {

  startUp() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    utils.documentsDirectory = documentsDirectory;
    runApp(const FlutterBook());
  }

  startUp();

}

class FlutterBook extends StatelessWidget {
  const FlutterBook({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("FlutterBook"),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.date_range), text: "Встречи",),
                  Tab(icon: Icon(Icons.date_range), text: "Контакты",),
                  Tab(icon: Icon(Icons.date_range), text: "Заметки",),
                  Tab(icon: Icon(Icons.date_range), text: "Задачи",),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Notes()
              ]
            ),
          )
      ),
    );
  }


}
