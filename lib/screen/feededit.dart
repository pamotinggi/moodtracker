import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/model/feed_model.dart';
import 'package:moodtracker/model/viewfeed.dart';
import 'package:moodtracker/screen/homescreen.dart';

class FeedEdit extends StatefulWidget {
  final viewfeed cards;
  const FeedEdit({Key? key, required this.cards}) : super(key: key);

  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {
  late String id;
  late String content;
  late String date;
  final TextEditingController feedcController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  feed feedmodel = new feed();

  @override
  void initState() {
    id = widget.cards.id!;
    content = widget.cards.content!;
    date = widget.cards.date!;
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
        title: Text("Edit Feed"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 15,
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
                controller: feedcController,
                maxLines: 5,
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
                  final docUser = FirebaseFirestore.instance
                      .collection('feed_entry')
                      .doc(user!.email)
                      .collection('entry')
                      .doc(id);

                  docUser.update({
                    'content': feedcController.text,
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
            SizedBox(
              height: 15,
            ),
            Material(
              elevation: 3,
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(40),
              child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                onPressed: () {
                  String pub_date = date;
                  String pub_id = id;
                  String pub_cont = content;

                  Map<String, dynamic> data = {
                    "id": pub_id,
                    "date": pub_date,
                    "content": pub_cont,
                  };

                  FirebaseFirestore.instance
                      .collection('pub_feed')
                      .doc(user!.email)
                      .collection('entry')
                      .doc(id)
                      .set(data);

                  final snackBar =
                  SnackBar(content: const Text("Mood Entry Edited"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text(
                  "Make It Pub",
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
