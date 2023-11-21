import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController; // Use GoogleMapController?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Example'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Initial map coordinates
          zoom: 12.0,
        ),
        markers: Set<Marker>.from([
          Marker(
            markerId: MarkerId('marker_id'),
            position: LatLng(37.7749, -122.4194),
            infoWindow: InfoWindow(
              title: 'Marker Title',
              snippet: 'Marker Snippet',
            ),
          ),
        ]),
      ),
    );
  }
}
