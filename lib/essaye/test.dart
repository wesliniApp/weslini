import 'dart:convert';
import 'dart:math' show cos, sqrt, asin, sin, pi;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  Map<String, LatLng> cities = {
    'Tenes': LatLng(36.517, 1.316),
    'Alger': LatLng(36.7538, 3.0588),
    'Oran': LatLng(35.697, -0.63),
    'Chlef': LatLng(36.1667, 1.3333),
  };

  @override
  void initState() {
    super.initState();
    addMarkers();
    calculerDistances();
  }

  void addMarkers() {
    cities.forEach((key, value) {
      markers.add(
        Marker(
          markerId: MarkerId(key),
          position: value,
          infoWindow: InfoWindow(title: key),
        ),
      );
    });
  }

  void calculerDistances() async {
    LatLng? tenesCoords = cities['Tenes'];
    double distanceMinimale = double.infinity;

    for (var entry in cities.entries) {
      if (entry.key != 'Tenes') {
        double distance = await getDistance(tenesCoords!, entry.value);
        print('Distance entre Tenes et ${entry.key} : $distance km');
        if (distance < distanceMinimale) {
          distanceMinimale = distance;
        }
      }
    }

    print('La distance minimale est : $distanceMinimale km');
  }

  double calculateDistance(LatLng startCoords, LatLng endCoords) {
    const double radiusTerre = 6371; // Rayon de la Terre en kilomètres

    double lat1 = startCoords.latitude;
    double lon1 = startCoords.longitude;
    double lat2 = endCoords.latitude;
    double lon2 = endCoords.longitude;

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * asin(sqrt(a));
    return radiusTerre * c;
  }

  double _toRadians(double degrees) {
    return degrees * (pi / 180);
  }

  Future<double> getDistance(LatLng startCoords, LatLng endCoords) async {
    String apiKey = 'AIzaSyABw-J_9Weu9yHhveob-0tcBV4ZlCz8vkM';
    String baseUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startCoords.latitude},${startCoords.longitude}&destination=${endCoords.latitude},${endCoords.longitude}&key=$apiKey';

    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['routes'] != null &&
          data['routes'].isNotEmpty &&
          data['routes'][0]['legs'] != null &&
          data['routes'][0]['legs'].isNotEmpty &&
          data['routes'][0]['legs'][0]['distance'] != null &&
          data['routes'][0]['legs'][0]['distance']['value'] != null) {
        print('response reussiteeeiiif');
        double distanceValue = double.parse(
                data['routes'][0]['legs'][0]['distance']['value'].toString()) /
            1000; // Convertir la distance en kilomètres
        return distanceValue;
      } else {
        print('Invalid or missing data in API response for distance');
        return 1.0;
      }
    } else {
      print('Erreur de requête HTTP');
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carte avec marqueurs'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(36.517, 1.316),
          zoom: 6.0,
        ),
        markers: markers,
      ),
    );
  }
}
