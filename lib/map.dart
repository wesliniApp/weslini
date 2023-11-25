import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Marker _userLocationMarker = Marker(
    markerId: MarkerId('user_location'),
    position: LatLng(
        0.0, 0.0), // Position initiale (0,0) pour éviter les erreurs au départ
  );
  String _locationMessage = '';

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
  }

  // Méthode pour demander l'autorisation d'accès à la localisation
  void _getLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = 'L\'autorisation de localisation est refusée';
      });
    } else {
      _getCurrentLocation();
    }
  }

  // Méthode pour obtenir la localisation actuelle
  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _locationMessage =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";

        _userLocationMarker = Marker(
          markerId: MarkerId('user_location'),
          position: LatLng(position.latitude, position.longitude),
          // Autres propriétés du marqueur si nécessaire
        );
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Impossible d\'obtenir la localisation';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localisation sur la carte'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(0.0, 0.0), // Position initiale de la carte (0,0)
              zoom: 12.0,
            ),
            markers: {
              _userLocationMarker,
              // Autres marqueurs s'il y en a d'autres sur la carte
            },
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            // Autres propriétés de GoogleMap
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _locationMessage,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
