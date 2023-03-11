import 'package:flutter/material.dart';
import 'package:moodtracker/screen/feedscreen.dart';
import 'package:moodtracker/screen/mymood.dart';
import 'package:moodtracker/screen/sharefeed.dart';
import 'package:moodtracker/screen/updatemood.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> screens = [
    FeedScreen(),
    ShareFeed(),
    //UpdateMood(),
    MyMood(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.pinkAccent.shade100,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Feed'),
          NavigationDestination(icon: Icon(Icons.lightbulb), label: 'Thoughts'),
         //NavigationDestination(icon: Icon(Icons.update), label: 'Update Mood'),
          NavigationDestination(icon: Icon(Icons.mood), label: 'My Mood'),
        ],
      ),
    );
  }
}
