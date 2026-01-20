import 'package:flutter/material.dart';
import '../models/artist_model.dart';
import '../widgets/artist_avatar.dart';
import '../widgets/section_header.dart';

class MusicPage extends StatelessWidget {
  MusicPage({Key? key}) : super(key: key);

  final List<Artist> featuredMusicians = [
    Artist(name: 'Ravi Shankar', specialty: 'Sitar Maestro', imagePath: 'lib/assets/images/artist_rohan.png'),
    Artist(name: 'Zakir Hussain', specialty: 'Tabla Virtuoso', imagePath: 'lib/assets/images/artist_rohan.png'),
    Artist(name: 'Lata Mangeshkar', specialty: 'Vocal Legend', imagePath: 'lib/assets/images/artist_anjali.png'),
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
                  child: Image.asset('lib/assets/images/music_illustration.png'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Hindustani Classical',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SectionHeader(title: 'Featured Musicians'),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredMusicians.length,
              itemBuilder: (context, index) {
                return ArtistAvatar(artist: featuredMusicians[index]);
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
                  child: Image.asset('lib/assets/images/class_tabla.png'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Introduction to Tabla Rhythms',
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