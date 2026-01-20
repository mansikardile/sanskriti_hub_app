class Place {
  final String name;
  final String vicinity;
  final String placeId;
  final String? photoReference;

  Place({
    required this.name,
    required this.vicinity,
    required this.placeId,
    this.photoReference,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'] ?? '',
      vicinity: json['vicinity'] ?? '',
      placeId: json['place_id'] ?? '',
      photoReference: json['photos'] != null && (json['photos'] as List).isNotEmpty
          ? json['photos'][0]['photo_reference']
          : null,
    );
  }
}
