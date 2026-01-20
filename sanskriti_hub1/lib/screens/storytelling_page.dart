import 'package:flutter/material.dart';
import '../models/artist_model.dart';
import '../widgets/artist_avatar.dart';
import '../widgets/section_header.dart';

class StorytellingPage extends StatelessWidget {
  StorytellingPage({Key? key}) : super(key: key);

  final List<Artist> featuredStorytellers = [
    Artist(name: 'Girish Karnad', specialty: 'Playwright & Author', imagePath: 'lib/assets/images/artist_kavya.png'),
    Artist(name: 'Sudha Murthy', specialty: 'Contemporary Mythology', imagePath: 'lib/assets/images/artist_anjali.png'),
    Artist(name: 'Vikram Sampath', specialty: 'Historian', imagePath: 'lib/assets/images/artist_rohan.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('lib/assets/images/storytelling_illustration.png'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Tales of Panchatantra',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SectionHeader(title: 'Featured Storytellers'),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredStorytellers.length,
              itemBuilder: (context, index) {
                return ArtistAvatar(artist: featuredStorytellers[index]);
              },
            ),
          ),
          const SectionHeader(title: 'Popular Series'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('lib/assets/images/class_storytelling.png'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'The Art of Kathakathan',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}