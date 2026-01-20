enum CraftCategory { all, textile, pottery, jewelry, wood }

class CraftItem {
  final String title;
  final String artisan;
  final String imagePath;
  final CraftCategory category;
  final String price; // ADDED THIS LINE

  CraftItem({
    required this.title,
    required this.artisan,
    required this.imagePath,
    required this.category,
    required this.price, // ADDED THIS LINE
  });
}