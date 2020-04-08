import 'package:flutter/material.dart';
import 'package:task_manager/model/items.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Task Manager"),
        backgroundColor: Colors.black54,
      ),
      body: TaskmanagerScreen(),
    );
  }
}