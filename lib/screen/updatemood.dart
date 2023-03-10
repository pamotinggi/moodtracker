import 'package:flutter/material.dart';

class UpdateMood extends StatefulWidget {
  const UpdateMood({Key? key}) : super(key: key);

  @override
  State<UpdateMood> createState() => _UpdateMoodState();
}

class _UpdateMoodState extends State<UpdateMood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Mood"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
