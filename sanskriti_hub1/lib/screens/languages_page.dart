import 'package:flutter/material.dart';
import '../models/artist_model.dart';
import '../widgets/artist_avatar.dart';
import '../widgets/section_header.dart';

class LanguagesPage extends StatelessWidget {
  LanguagesPage({Key? key}) : super(key: key);

  final List<Artist> featuredGurus = [
    Artist(name: 'Dr. Devi Prasad', specialty: 'Sanskrit Scholar', imagePath: 'lib/assets/images/artist_kavya.png'),
    Artist(name: 'Priya Mehta', specialty: 'Hindi Linguistics', imagePath: 'lib/assets/images/artist_anjali.png'),
    Artist(name: 'Arun Kumar', specialty: 'Dravidian Languages', imagePath: 'lib/assets/images/artist_rohan.png'),
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
                  child: Image.asset('lib/assets/images/languages_illustration.png'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'The Beauty of Devanagari',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SectionHeader(title: 'Featured Gurus'),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredGurus.length,
              itemBuilder: (context, index) {
                return ArtistAvatar(artist: featuredGurus[index]);
              },
            ),
          ),
          const SectionHeader(title: 'Popular Courses'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('lib/assets/images/class_sanskrit.png'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Beginner\'s Sanskrit',
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