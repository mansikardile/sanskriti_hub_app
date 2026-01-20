import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'discover_places_screen.dart'; // <-- FIX #1: Corrected the import path to be relative
import '../models/craft_model.dart';

class CraftsScreen extends StatefulWidget {
  const CraftsScreen({Key? key}) : super(key: key);

  @override
  State<CraftsScreen> createState() => _CraftsScreenState();
}

class _CraftsScreenState extends State<CraftsScreen> {
  // Master list of all craft items with prices
  final List<CraftItem> _masterCraftList = [
    CraftItem(title: 'Banarasi Silk Sari', artisan: 'Varanasi Weavers', imagePath: 'lib/assets/images/textile_banarasi.png', category: CraftCategory.textile, price: '₹ 15,000'),
    CraftItem(title: 'Jaipur Blue Pottery', artisan: 'Rajasthan Potters', imagePath: 'lib/assets/images/pottery_blue.png', category: CraftCategory.pottery, price: '₹ 3,200'),
    CraftItem(title: 'Kundan Necklace', artisan: 'Royal Jewelers of Jaipur', imagePath: 'lib/assets/images/jewelry_kundan.png', category: CraftCategory.jewelry, price: '₹ 22,000'),
    CraftItem(title: 'Kashmiri Walnut Box', artisan: 'Woodworkers of Srinagar', imagePath: 'lib/assets/images/wood_walnut.png', category: CraftCategory.wood, price: '₹ 4,500'),
    CraftItem(title: 'Bandhani Tie-Dye', artisan: 'Artisans of Kutch', imagePath: 'lib/assets/images/textile_bandhani.png', category: CraftCategory.textile, price: '₹ 2,100'),
    CraftItem(title: 'Nizamabad Black Pottery', artisan: 'Local Clay Masters', imagePath: 'lib/assets/images/pottery_black.png', category: CraftCategory.pottery, price: '₹ 1,800'),
    CraftItem(title: 'Traditional Temple Jewelry', artisan: 'Southern Goldsmiths', imagePath: 'lib/assets/images/jewelry_temple.png', category: CraftCategory.jewelry, price: '₹ 45,000'),
    CraftItem(title: 'Sandalwood Carving', artisan: 'Mysuru Sculptors', imagePath: 'lib/assets/images/wood_sandalwood.png', category: CraftCategory.wood, price: '₹ 7,500'),
  ];

  late List<CraftItem> _displayedCraftList;
  CraftCategory _selectedCategory = CraftCategory.all;

  @override
  void initState() {
    super.initState();
    _displayedCraftList = List.from(_masterCraftList);
  }

  void _filterCrafts(CraftCategory category) {
    setState(() {
      _selectedCategory = category;
      if (category == CraftCategory.all) {
        _displayedCraftList = List.from(_masterCraftList);
      } else {
        _displayedCraftList = _masterCraftList
            .where((item) => item.category == category)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F2),
      drawer: _buildAppDrawer(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'Discover Crafts',
          style: GoogleFonts.playfairDisplay(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              padding: const EdgeInsets.all(12),
              itemCount: _displayedCraftList.length,
              itemBuilder: (context, index) {
                return _CraftCard(item: _displayedCraftList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _buildChip(CraftCategory.all, "All"),
          _buildChip(CraftCategory.textile, "Textiles"),
          _buildChip(CraftCategory.pottery, "Pottery"),
          _buildChip(CraftCategory.jewelry, "Jewelry"),
          _buildChip(CraftCategory.wood, "Wood"),
        ],
      ),
    );
  }

  Widget _buildChip(CraftCategory category, String label) {
    bool isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          if (selected) {
            _filterCrafts(category);
          }
        },
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFFF26722),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.transparent)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }
  
  Widget _buildAppDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFF26722)),
            child: Text(
              'Explore More',
              style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.place_outlined),
            title: const Text('Discover Nearby Places'),
            onTap: () {
              Navigator.pop(context);
              // <-- FIX #2: Removed 'const' because DiscoverPlacesScreen is a StatefulWidget
              Navigator.push(context, MaterialPageRoute(builder: (context) => DiscoverPlacesScreen()));
            },
          ),
        ],
      ),
    );
  }
}

class _CraftCard extends StatelessWidget {
  final CraftItem item;
  const _CraftCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(item.imagePath, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.artisan,
                  style: GoogleFonts.poppins(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  item.price,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFF26722),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}