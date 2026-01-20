import 'package:flutter/material.dart';
import 'package:sanskriti_hub_app/screens/dance_page.dart';
import 'package:sanskriti_hub_app/screens/languages_page.dart';
import 'package:sanskriti_hub_app/screens/music_page.dart';
import 'package:sanskriti_hub_app/screens/storytelling_page.dart';

// Class name and file renamed
class CoursesScreen extends StatelessWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF9F2),
        // DRAWER AND LEADING ICON HAVE BEEN REMOVED FROM HERE
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false, // Prevents default back button
          title: const Text(
            'Learn a Skill', // Title updated
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Color(0xFFF26722),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFFF26722),
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Dance'),
              Tab(text: 'Music'),
              Tab(text: 'Storytelling'),
              Tab(text: 'Languages'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DancePage(),
            MusicPage(),
            StorytellingPage(),
            LanguagesPage(),
          ],
        ),
      ),
    );
  }
}