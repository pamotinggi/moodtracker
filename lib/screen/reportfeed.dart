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
  late String content;
  late String date;
  late TextEditingController contentController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  feed feedmodel = feed();

  @override
  void initState() {
    id = widget.card.id!;
    content = widget.card.content!;
    date = widget.card.date!;
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
        title: Text("Report this feed"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Report This Feed",
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
                controller: contentController,
                maxLines: 5,
                enabled: false,
                decoration: InputDecoration(
                  hintText: content,
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
                  Map<String, dynamic> data = {
                    "id": id,
                    "date": date,
                    "content": content,
                  };
                  FirebaseFirestore.instance
                      .collection('reported_feed')
                      .doc(user!.uid)
                      .set(data);
                  final snackBar =
                      SnackBar(content: const Text("Report Edited Edited"));
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
