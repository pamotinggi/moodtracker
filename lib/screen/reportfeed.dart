import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/model/feed_model.dart';
import 'package:moodtracker/model/viewfeed.dart';
import 'package:moodtracker/screen/homescreen.dart';

class ReportFeed extends StatefulWidget {
  final viewfeed card;
  const ReportFeed({Key? key, required this.card}) : super(key: key);

  @override
  State<ReportFeed> createState() => _ReportFeedState();
}

class _ReportFeedState extends State<ReportFeed> {
  late String id;
  late String happen;
  String moodent = "";
  final TextEditingController causeController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  feed feedmodel = feed();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report this feed"),
      ),
      body: Center(
        child: Column(
          children: [
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
                  hintText: happen,
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
                  final docUser = FirebaseFirestore.instance
                      .collection('mood_entry')
                      .doc(user!.email)
                      .collection('entry')
                      .doc(id);

                  docUser.update({
                    'feel': moodent,
                    'happen': causeController.text,
                  });
                  final snackBar =
                      SnackBar(content: const Text("Mood Entry Edited"));
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
