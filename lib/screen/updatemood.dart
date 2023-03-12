import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moodtracker/model/mood__model.dart';
import 'package:moodtracker/screen/mymood.dart';

class UpdateMood extends StatefulWidget {
  const UpdateMood({Key? key}) : super(key: key);

  @override
  State<UpdateMood> createState() => _UpdateMoodState();
}

class _UpdateMoodState extends State<UpdateMood> {
  String moodent = "";
  final TextEditingController causeController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  mood moodmodel = new mood();

  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.moodmodel = mood.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Mood"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 27,
            ),
            Text(
              "How's your day ?",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            EmojiFeedback(
              curve: Curves.bounceIn,
              inactiveElementBlendColor: Colors.grey,
              inactiveElementScale: 0.5,
              onChanged: (value) {
                if (value == 1) {
                  print("Terrible");
                  moodent = "Terribe 😖";
                } else if (value == 2) {
                  print("sad");
                  moodent = "Sad 😣";
                } else if (value == 3) {
                  print("good");
                  moodent = "Good 🙂";
                } else if (value == 4) {
                  print("very good");
                  moodent = "Very Good 😄";
                } else if (value == 5) {
                  print("awesome");
                  moodent = "Awesome 😍";
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "What happened ?",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: causeController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Material(
              elevation: 3,
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(40),
              child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                onPressed: () {
                  String id = DateTime.now().toString();
                  DateTime dateToday = DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day);
                  String date = dateToday.toString();

                  Map<String, dynamic> data = {
                    "id": id,
                    "date": date,
                    "feel": moodent,
                    "happen": causeController.text,
                  };
                  FirebaseFirestore.instance
                      .collection('mood_entry')
                      .doc(user!.email)
                      .collection('entry')
                      .doc(id)
                      .set(data);

                  final snackBar =
                      SnackBar(content: const Text("Mood Entry Submitted"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyMood()));
                },
                child: Text(
                  "Save Mood",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
