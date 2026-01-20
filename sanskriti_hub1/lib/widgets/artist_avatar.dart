import 'package:flutter/material.dart';
import '../models/artist_model.dart';

class ArtistAvatar extends StatelessWidget {
  final Artist artist;
  const ArtistAvatar({Key? key, required this.artist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage(artist.imagePath),
          ),
          const SizedBox(height: 10),
          Text(
            artist.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            artist.specialty,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}