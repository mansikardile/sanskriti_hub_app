import 'package:flutter/material.dart';
import 'package:sanskriti_hub_app/screens/dance_page.dart';
import 'package:sanskriti_hub_app/screens/languages_page.dart';
import 'package:sanskriti_hub_app/screens/music_page.dart';
import 'package:sanskriti_hub_app/screens/storytelling_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // The number of tabs
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF9F2),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Sanskriti Hub',
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
        // The TabBarView displays the content for the selected tab
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