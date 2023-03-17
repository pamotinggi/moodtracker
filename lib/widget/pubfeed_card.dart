import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/model/viewfeed.dart';
import 'package:moodtracker/screen/reportfeed.dart';

class PubCard extends StatelessWidget {
  late viewfeed card;
  PubCard(this.card);

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
                    '${card.content}',
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
                          builder: (context) => ReportFeed()));
                },
                icon: Icon(Icons.report),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
