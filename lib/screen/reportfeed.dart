import 'package:flutter/material.dart';

class ReportFeed extends StatefulWidget {
  const ReportFeed({Key? key}) : super(key: key);

  @override
  State<ReportFeed> createState() => _ReportFeedState();
}

class _ReportFeedState extends State<ReportFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Report this feed"),
      ),
    );
  }
}
