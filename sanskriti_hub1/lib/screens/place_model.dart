class Place {
  final String placeId;
  final String name;
  final String vicinity; // The address or neighborhood
  final String? photoReference; // The ID for the photo

  Place({
    required this.placeId,
    required this.name,
    required this.vicinity,
    this.photoReference,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json['place_id'],
      name: json['name'],
      vicinity: json['vicinity'] ?? 'No address provided',
      photoReference: json['photos'] != null ? json['photos'][0]['photo_reference'] : null,
    );
  }
}

