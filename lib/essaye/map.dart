import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math' show asin, cos, pi, pow, sin, sqrt;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  List<Marker> markers = [];
  late Set<Polyline> polylines = {};
  double distance = 0.0;

  @override
  void initState() {
    super.initState();
    // Ajouter un marqueur pour Tenes
    _addMarker(36.4997, 1.3106, 'Ténès');
    // Ajouter un marqueur pour Chlef
    _addMarker(36.1667, 1.3333, 'Chlef');

    // Appel pour obtenir l'itinéraire entre Tenes et Chlef
    _getPolyline(
      LatLng(36.4997, 1.3106), // Coordonnées de Tenes
      LatLng(36.1667, 1.3333), // Coordonnées de Chlef
    );
  }

  void _calculateDistance(List<LatLng> decodedPoints, http.Response response) {
    if (decodedPoints.isNotEmpty) {
      // Use the first point as the starting point
      LatLng startingPoint = decodedPoints.first;

      // Access the distance from the API response
      Map values = jsonDecode(response.body);
      int distanceInMeters =
          values["routes"][0]["legs"][0]["distance"]["value"];

      // Convert meters to kilometers and update the state
      double distanceInKm = distanceInMeters / 1000;
      setState(() {
        distance = distanceInKm;
      });
      print('Distance entre Tenes et Chlef: $distance km');
    }
  }

  double distanceBetween(LatLng from, LatLng to) {
    const int earthRadius = 6371; // Rayon de la Terre en km
    double lat1 = _toRadians(from.latitude);
    double lon1 = _toRadians(from.longitude);
    double lat2 = _toRadians(to.latitude);
    double lon2 = _toRadians(to.longitude);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a =
        pow(sin(dLat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);
    double c = 2 * asin(sqrt(a));
    return earthRadius * c;
  }

  double _toRadians(double degrees) {
    return degrees * (pi / 180);
  }

  void _addMarker(double lat, double lng, String markerId) {
    Marker marker = Marker(
      markerId: MarkerId(markerId),
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );
    markers.add(marker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carte avec des marqueurs'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(36.3333, 1.5), // Centre entre Chlef et Ténès
          zoom: 8,
        ),
        markers: Set<Marker>.of(markers),
        polylines: polylines,
        onTap: (LatLng position) {
          setState(() {
            if (markers.length < 3) {
              _addMarker(position.latitude, position.longitude, 'Nouveau');
              if (markers.length == 3) {
                _getPolyline(
                    markers
                        .firstWhere(
                            (marker) => marker.markerId.value == 'Chlef')
                        .position,
                    markers
                        .firstWhere(
                            (marker) => marker.markerId.value == 'Ténès')
                        .position);
              }
            }
          });
        },
      ),
    );
  }

  void _getPolyline(LatLng origin, LatLng destination) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/js?sensor=false&callback=myMap/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=AIzaSyABw-J_9Weu9yHhveob-0tcBV4ZlCz8vkM";
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map values = jsonDecode(response.body);
      List<dynamic> routes = values["routes"];
      if (routes.isNotEmpty) {
        String encodedPolyline = routes[0]["overview_polyline"]["points"];
        List<LatLng> decodedPoints = _decodePoly(encodedPolyline);
        if (decodedPoints.isNotEmpty) {
          _drawPolyline(decodedPoints);

          _calculateDistance(decodedPoints, response);
        }
      }
    }
  }

  void _drawPolyline(List<LatLng> points) {
    setState(() {
      polylines.add(
        Polyline(
          polylineId: PolylineId('poly'),
          points: points,
          color: Colors.blue,
          width: 3,
        ),
      );
    });
  }

  List<LatLng> _decodePoly(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng((lat / 1E5), (lng / 1E5)));
    }
    return points;
  }

  double _haversine(double val) {
    return pow(sin(val / 2), 2).toDouble();
  }
}
