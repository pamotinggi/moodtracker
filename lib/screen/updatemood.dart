import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UpdateMood extends StatefulWidget {
  const UpdateMood({Key? key}) : super(key: key);

  @override
  State<UpdateMood> createState() => _UpdateMoodState();
}

class _UpdateMoodState extends State<UpdateMood> {
  final TextEditingController moodController = TextEditingController();
  final TextEditingController feelingController = TextEditingController();
  final TextEditingController causeController = TextEditingController();
  final TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Mood"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 27,
            ),
            Text(
              "How's your day ?",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            /*RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),*/
            EmojiFeedback(
              curve: Curves.bounceIn,
              inactiveElementBlendColor: Colors.grey,
              inactiveElementScale: 0.5,
              onChanged: (value) {
                if (value == 1) {
                  print("Terrible");
                }
                else if( value == 2){
                  print("sad");
                }
                else if( value == 3){
                  print("good");
                }
                else if( value == 4){
                  print("very good");
                }
                else if( value == 5){
                  print("awesome");
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "What happened ?",
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
                controller: causeController,
                maxLines: 5,
                decoration: InputDecoration(
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
                onPressed: () {},
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
