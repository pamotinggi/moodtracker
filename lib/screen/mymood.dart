import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moodtracker/screen/updatemood.dart';

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
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.add),
              label: 'New Entry',
              backgroundColor: Colors.pinkAccent,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UpdateMood()));
              }),
        ],
      ),
    );
  }
}
