import 'package:flutter/material.dart';
import 'package:sanskriti_hub_app/screens/community_screen.dart';
import 'package:sanskriti_hub_app/screens/crafts_screen.dart'; // Import this
import 'package:sanskriti_hub_app/screens/courses_screen.dart'; // Import this (the renamed file)
import 'package:sanskriti_hub_app/screens/home_page.dart';
import 'package:sanskriti_hub_app/screens/profile_screen.dart';
  

void main() {
  runApp(const SanskritiHubApp());
}

class SanskritiHubApp extends StatelessWidget {
  const SanskritiHubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanskriti Hub',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  // This function now navigates to the LEARN tab (index 2)
  void _navigateToCourses() {
    setState(() {
      _selectedIndex = 2; 
    });
  }

  @override
  Widget build(BuildContext context) {
    // THE NAVIGATION ORDER IS NOW UPDATED
    final List<Widget> _widgetOptions = <Widget>[
      HomePage(onDiscoverCoursesPressed: _navigateToCourses),
      const CraftsScreen(),      // Discover is now Crafts
      const CoursesScreen(),     // Learn is now the Courses screen
      const CommunityScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFFF26722),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brush_outlined), // Icon changed for Crafts
            activeIcon: Icon(Icons.brush),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}