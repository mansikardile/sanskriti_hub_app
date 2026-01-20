import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanskriti_hub_app/screens/placeholder_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'Riya Sharma';
  String _userLocation = 'pune, india';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'My Profile',
          style: GoogleFonts.playfairDisplay(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 30),
          _buildStatsCounter(),
          const SizedBox(height: 30),
          _buildProfileMenu(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
         CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/default_profile.png'), // CORRECTED PATH
        ),
        const SizedBox(height: 16),
        Text(
          _userName,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _userLocation,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => _showEditProfileSheet(context),
          icon: const Icon(Icons.edit_outlined, size: 18),
          label: const Text('Edit Profile'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFF26722),
            side: const BorderSide(color: Color(0xFFF26722)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildStatsCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatColumn('12', 'Courses'),
        _buildStatColumn('3', 'Certificates'),
        _buildStatColumn('7', 'Artisans'),
      ],
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuTile(
            context,
            icon: Icons.school_outlined,
            title: 'My Courses',
            onTap: () => _navigateToPlaceholder(context, 'My Courses'),
          ),
          _buildMenuTile(
            context,
            icon: Icons.favorite_border,
            title: 'My Wishlist',
            onTap: () => _navigateToPlaceholder(context, 'My Wishlist'),
          ),
          _buildMenuTile(
            context,
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () => _navigateToPlaceholder(context, 'Settings'),
          ),
          _buildMenuTile(
            context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () => _navigateToPlaceholder(context, 'Help & Support'),
          ),
          _buildMenuTile(
            context,
            icon: Icons.logout,
            title: 'Logout',
            isLogout: true,
            onTap: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    final color = isLogout ? Colors.red : Colors.black87;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
      trailing: isLogout
          ? null
          : const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _navigateToPlaceholder(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlaceholderScreen(pageTitle: title)),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditProfileSheet(BuildContext context) {
    final nameController = TextEditingController(text: _userName);
    final locationController = TextEditingController(text: _userLocation);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Edit Profile', style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF26722),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Save Changes', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    _userName = nameController.text;
                    _userLocation = locationController.text;
                  });
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
