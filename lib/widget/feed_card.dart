import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/model/viewfeed.dart';
import 'package:moodtracker/screen/feededit.dart';
import 'package:moodtracker/screen/homescreen.dart';

class FeedCard extends StatelessWidget {
  late viewfeed cards;
  FeedCard(this.cards);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

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
                    "Date : " + '${cards.date}',
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
                    '${cards.content}',
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
                          builder: (context) => FeedEdit(cards : cards)));
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  final snackBar =
                  SnackBar(content: const Text("Entry Deleted"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  final docUser = FirebaseFirestore.instance
                      .collection('feed_entry')
                      .doc(user!.email)
                      .collection('entry')
                      .doc(cards.id);

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
