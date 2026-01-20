import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onDiscoverCoursesPressed;

  const HomePage({Key? key, required this.onDiscoverCoursesPressed})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  final List<String> _carouselImages = [
    'lib/assets/images/carousel_dance.png',
    'lib/assets/images/carousel_crafts.png',
    'lib/assets/images/carousel_festival.png',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _carouselImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F2),
      body: CustomScrollView(
        slivers: [
          _buildHeroSection(),
          _buildWelcomeMessage(),
          _buildSectionHeader("Featured Course"),
          _buildFeaturedCourseCard(),
          _buildSectionHeader("Why You'll Love Sanskriti Hub"),
          _buildWhyHubSection(),
          _buildSectionHeader("A Word from Our Gurus"),
          _buildTestimonialCard(),
          _buildFinalCallToAction(),
        ],
      ),
    );
  }

SliverToBoxAdapter _buildHeroSection() {
    return SliverToBoxAdapter(
      child: Container(
        height: 400,
        child: Stack(
          children: [
            // The Image Carousel remains the same
            PageView.builder(
              controller: _pageController,
              itemCount: _carouselImages.length,
              itemBuilder: (context, index) {
                return Image.asset(_carouselImages[index], fit: BoxFit.cover);
              },
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),

            // --- NEW: Top Gradient for Text Readability ---
            // This ensures the title is always readable against any image
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.4],
                ),
              ),
            ),
            
            // The Bottom Gradient remains the same
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),

            // --- NEW: Positioned App Title ---
            // This is the new, visible "Sanskriti Hub" title
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    children: [
                      // Optional: A subtle icon for branding
                      const Icon(Icons.spa_outlined, color: Colors.white, size: 28),
                      const SizedBox(width: 10),
                      Text(
                        'Sanskriti Hub',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // The main hero text at the bottom remains the same
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Soul of India, in Your Hands.',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: widget.onDiscoverCoursesPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF26722),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Begin Your Journey',
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  SliverToBoxAdapter _buildWelcomeMessage() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Namaste!',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "As the vibrant days of Navratri unfold, it's a perfect time to connect with traditions. What will you discover today?",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          title,
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildFeaturedCourseCard() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('lib/assets/images/featured_course_kathakali.png', fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Expressive World of Kathakali',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Uncover the dramatic makeup, intricate gestures, and powerful storytelling of Kerala\'s iconic dance-drama.',
                      style: GoogleFonts.poppins(color: Colors.black54),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildWhyHubSection() {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: [
          _buildWhyItem(Icons.movie_filter_outlined, 'Authentic Learning',
              'Learn directly from masters and practitioners of ancient arts.'),
          _buildWhyItem(Icons.video_library_outlined, 'Rich Content Library',
              'Explore a vast and growing collection of high-quality courses.'),
          _buildWhyItem(Icons.people_alt_outlined, 'Vibrant Community',
              'Connect with fellow learners and enthusiasts from around the world.'),
        ],
      ),
    ));
  }

  Widget _buildWhyItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: const Color(0xFFF26722)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.poppins(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildTestimonialCard() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 0,
          color: const Color(0xFFF2EADC),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('lib/assets/images/guru_portrait.png'),
                ),
                const SizedBox(height: 15),
                Text(
                  '"To teach is to touch a life forever. Here, we don\'t just share an art form, we share a soul."',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '- Pt. Hariprasad Sharma, Sitar Guru',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverPadding _buildFinalCallToAction() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
      sliver: SliverToBoxAdapter(
        child: ElevatedButton(
          onPressed: widget.onDiscoverCoursesPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF26722),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'Explore All Courses',
            style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}