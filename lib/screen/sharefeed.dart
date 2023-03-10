import 'package:flutter/material.dart';

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
        title: Text("Share Feed"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
