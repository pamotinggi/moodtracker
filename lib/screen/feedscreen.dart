import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/model/user_model.dart';
import 'package:moodtracker/model/viewfeed.dart';
import 'package:moodtracker/widget/feed_card.dart';
import 'package:moodtracker/widget/pubfeed_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel _userModel = UserModel();
  List<Object> _itemList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this._userModel = UserModel.fromMap(value.data());
      setState(() {});
    });
    getFeedList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed Screen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _itemList.length,
            itemBuilder: (context, index) {
              final item = _itemList[index];
              return PubCard(_itemList[index] as viewfeed);
            }),
      ),
    );
  }

  Future getFeedList() async{
    var data = await FirebaseFirestore.instance
        .collection('pub_feed')
        .get();
    setState(() {
      _itemList = List.from(data.docs.map((doc) => viewfeed.fromSnapshot(doc)));
    });
  }
}
