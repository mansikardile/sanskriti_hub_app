import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A simple, reusable screen for menu items that are not yet built.
class PlaceholderScreen extends StatelessWidget {
  final String pageTitle;
  const PlaceholderScreen({Key? key, required this.pageTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          pageTitle,
          style: GoogleFonts.playfairDisplay(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          '$pageTitle is coming soon!',
          style: GoogleFonts.poppins(fontSize: 18, color: Colors.black54),
        ),
      ),
    );
  }
}