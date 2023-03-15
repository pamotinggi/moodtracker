import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moodtracker/screen/feedupdate.dart';

class ShareFeed extends StatefulWidget {
  const ShareFeed({Key? key}) : super(key: key);

  @override
  State<ShareFeed> createState() => _ShareFeedState();
}

class _ShareFeedState extends State<ShareFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Thoughts"),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeedUpdate()));
              }),
        ],
      ),
    );
  }
}
