import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/model/feed_model.dart';
import 'package:moodtracker/screen/homescreen.dart';

class FeedUpdate extends StatefulWidget {
  const FeedUpdate({Key? key}) : super(key: key);

  @override
  State<FeedUpdate> createState() => _FeedUpdateState();
}

class _FeedUpdateState extends State<FeedUpdate> {
  TextEditingController feedController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  feed feedmodel = new feed();

  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.feedmodel = feed.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("What's in ur mind ?"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 27,
            ),
            Text(
              "What are you thinking right now ?",
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
                controller: feedController,
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
                    "content": feedController.text,
                  };
                  FirebaseFirestore.instance
                      .collection('feed_entry')
                      .doc(user!.email)
                      .collection('entry')
                      .doc(id)
                      .set(data);

                  final snackBar =
                  SnackBar(content: const Text("Feed Entry Submitted"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
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
