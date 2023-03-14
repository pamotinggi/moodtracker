import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/model/mood__model.dart';
import 'package:moodtracker/model/viewmood.dart';
import 'package:moodtracker/screen/homescreen.dart';
import 'package:moodtracker/screen/moodedit.dart';

class MoodCard extends StatelessWidget {
  late viewmood card;
  MoodCard(this.card);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    mood moodmodel = new mood();

    return Container(
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 350,
            child: Card(
              color: Colors.pink,
              child: Column(
                children: <Widget>[
                  Text(
                    "Date : " + '${card.date}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Mood : " + '${card.feel}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${card.happen}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MoodEdit(card: card)));
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  final snackBar =
                      SnackBar(content: const Text("Entry Deleted"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  final docUser = FirebaseFirestore.instance
                      .collection('mood_entry')
                      .doc(user!.email)
                      .collection('entry')
                      .doc(card.id);

                  docUser.delete();

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
