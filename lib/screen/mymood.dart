import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moodtracker/model/user_model.dart';
import 'package:moodtracker/model/viewmood.dart';
import 'package:moodtracker/screen/loginscreen.dart';
import 'package:moodtracker/screen/updatemood.dart';
import 'package:moodtracker/widget/mood_card.dart';

class MyMood extends StatefulWidget {
  const MyMood({Key? key}) : super(key: key);

  @override
  State<MyMood> createState() => _MyMoodState();
}

class _MyMoodState extends State<MyMood> {
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
    getMemoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Mood"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.logout_outlined),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _itemList.length,
            itemBuilder: (context, index) {
              final item = _itemList[index];
              return MoodCard(_itemList[index] as viewmood);
            }),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.add),
              label: 'New Entry',
              backgroundColor: Colors.pinkAccent,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UpdateMood()));
              }),
        ],
      ),
    );
  }

  Future getMemoList() async {
    var data = await FirebaseFirestore.instance
        .collection('mood_entry')
        .doc(user!.email)
        .collection('entry')
        .get();
    setState(() {
      _itemList = List.from(data.docs.map((doc) => viewmood.fromSnapshot(doc)));
    });
  }
}
