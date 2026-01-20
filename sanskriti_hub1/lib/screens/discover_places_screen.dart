import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// Mock data for places with real coordinates in Pune, India
const List<Map<String, dynamic>> culturalPlaces = [
  {'name': 'Shaniwar Wada', 'lat': 18.5195, 'lon': 73.8553, 'desc': 'Historic fortification in Pune'},
  {'name': 'Aga Khan Palace', 'lat': 18.5513, 'lon': 73.9019, 'desc': 'Majestic palace with Italian arches'},
  {'name': 'Raja Dinkar Kelkar Museum', 'lat': 18.5135, 'lon': 73.8569, 'desc': 'Collection of Indian artifacts'},
  {'name': 'Pataleshwar Cave Temple', 'lat': 18.5284, 'lon': 73.8475, 'desc': 'Rock-cut cave temple from the 8th century'},
  {'name': 'Sinhagad Fort', 'lat': 18.3662, 'lon': 73.7558, 'desc': 'Hill fortress with panoramic views'},
  {'name': 'Lal Mahal', 'lat': 18.5191, 'lon': 73.8569, 'desc': 'Reconstruction of Shivaji Maharaj\'s palace'},
  {'name': 'Vishrambaug Wada', 'lat': 18.5152, 'lon': 73.8580, 'desc': 'Luxurious mansion of Peshwa Bajirao II'},
  {'name': 'Joshi\'s Museum of Miniature Railways', 'lat': 18.4988, 'lon': 73.8378, 'desc': 'Intricate miniature city model'},
  {'name': 'Tilak Museum (Kesari Wada)', 'lat': 18.5162, 'lon': 73.8546, 'desc': 'Residence of Bal Gangadhar Tilak'},
  {'name': 'Mahadji Shinde Chhatri', 'lat': 18.4905, 'lon': 73.8828, 'desc': 'Memorial to an 18th-century commander'},
];

class DiscoverPlacesScreen extends StatefulWidget {
  const DiscoverPlacesScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverPlacesScreen> createState() => _DiscoverPlacesScreenState();
}

class _DiscoverPlacesScreenState extends State<DiscoverPlacesScreen> {
  bool _isLoading = true;
  String _message = 'Finding nearby cultural places...';
  List<Map<String, dynamic>> _nearbyPlaces = [];

  @override
  void initState() {
    super.initState();
    _determinePositionAndFindPlaces();
  }

  Future<void> _determinePositionAndFindPlaces() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _message = 'Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _message = 'Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _message = 'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      _calculateDistancesAndSort(position);
    } catch (e) {
      setState(() => _message = 'Could not get location. Please try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _calculateDistancesAndSort(Position userPosition) {
    List<Map<String, dynamic>> placesWithDistance = [];
    for (var place in culturalPlaces) {
      double distanceInMeters = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        place['lat'],
        place['lon'],
      );
      var placeCopy = Map<String, dynamic>.from(place);
      placeCopy['distance'] = distanceInMeters / 1000; // convert to km
      placesWithDistance.add(placeCopy);
    }

    placesWithDistance.sort((a, b) => a['distance'].compareTo(b['distance']));
    setState(() => _nearbyPlaces = placesWithDistance.take(10).toList());
  }

  Future<void> _launchMaps(double lat, double lon) async {
    final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

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
          'Discover Nearby Places',
          style: GoogleFonts.playfairDisplay(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(), SizedBox(height: 16), Text(_message)]))
          : _nearbyPlaces.isEmpty
              ? Center(child: Text(_message))
              : ListView.builder(
                  itemCount: _nearbyPlaces.length,
                  itemBuilder: (context, index) {
                    final place = _nearbyPlaces[index];
                    return ListTile(
                      leading: Image.asset('lib/assets/images/place_icon.png', width: 40),
                      title: Text(place['name'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      subtitle: Text('${place['desc']} - ${place['distance'].toStringAsFixed(1)} km away'),
                      onTap: () => _launchMaps(place['lat'], place['lon']),
                    );
                  },
                ),
    );
  }
}