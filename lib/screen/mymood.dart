import 'package:flutter/material.dart';

class MyMood extends StatefulWidget {
  const MyMood({Key? key}) : super(key: key);

  @override
  State<MyMood> createState() => _MyMoodState();
}

class _MyMoodState extends State<MyMood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Mood"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
