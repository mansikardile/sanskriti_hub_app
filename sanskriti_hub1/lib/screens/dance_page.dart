import 'package:flutter/material.dart';
import '../models/artist_model.dart';
import '../widgets/artist_avatar.dart';
import '../widgets/section_header.dart';

class DancePage extends StatelessWidget {
  DancePage({Key? key}) : super(key: key);

  final List<Artist> featuredArtists = [
    Artist(name: 'Anjali Sharma', specialty: 'Bharatanatyam', imagePath: 'lib/assets/images/artist_anjali.png'),
    Artist(name: 'Rohan Verma', specialty: 'Hindustani Classical', imagePath: 'lib/assets/images/artist_rohan.png'),
    Artist(name: 'Kavya Iyer', specialty: 'Panchatantra Tales', imagePath: 'lib/assets/images/artist_kavya.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Dance Card
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('lib/assets/images/bharatanatyam_illustration.png'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Bharatanatyam',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Featured Artists Section
          const SectionHeader(title: 'Featured Artists'),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredArtists.length,
              itemBuilder: (context, index) {
                return ArtistAvatar(artist: featuredArtists[index]);
              },
            ),
          ),

          // Popular Classes Section
          const SectionHeader(title: 'Popular Classes'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('lib/assets/images/class_basics.png'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Bharatanatyam Basics',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Extra space at the bottom
        ],
      ),
    );
  }
}