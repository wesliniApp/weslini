import 'dart:convert';
import 'dart:math' show cos, sqrt, asin, sin, pi;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart'; // Importez cette ligne
import 'package:weslini/backend/utils.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(36.757574, 3.448430);
  LatLng? _currentPosition;

  List<Map<String, dynamic>> positions = [];
  bool isLoading = false;

  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    // Add a call to fetchPositions and chain the execution of calculerDistances
    fetchPositions().then((_) {
      _getCurrentLocation().then((_) {
        calculerDistances();
      });
    });
  }

  List<Map<String, dynamic>> dataPosition = [];

  Future<void> _getCurrentLocation() async {
    LocationData? locationData;

    try {
      var location = Location();
      locationData = await location.getLocation();
    } catch (e) {
      print('Error getting location: $e');
    }

    if (locationData != null) {
      setState(() {
        _currentPosition =
            LatLng(locationData!.latitude!, locationData.longitude!);
      });
    } else {
      print('Error: Location data is null.');
    }
  }

  Future<void> fetchPositions() async {
    print('hhhhhhhhh');
    try {
      final response =
          await http.get(Uri.parse('${Utils.baseUrl}/user/positions'));
      print('ssssssssss');

      if (response.statusCode == 200) {
        print('ccccccc');

        final dynamic responseData = jsonDecode(response.body);

        if (responseData != null && responseData['success']) {
          setState(() {
            positions = (responseData['positions'] as List<dynamic>)
                .cast<Map<String, dynamic>>();
            _generateDataPosition();
            _generateMarkers();
            print('datadfPosition, $_markers');
            print('positionsss, $positions');
          });
        } else {
          print('Failed to fetch positions1');
        }
      } else {
        print('Failed to fetch positions2');
      }
    } catch (error) {
      print('Error fetching positions: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _generateDataPosition() {
    dataPosition.clear(); // Clear existing data
    for (int i = 0; i < positions.length; i++) {
      double latitude = double.parse(positions[i]['latitude']);
      double longitude = double.parse(positions[i]['longitude']);

      dataPosition.add(
        {
          'id': i,
          'position': LatLng(latitude, longitude),
          'assetPath': 'assets/icon/car.png',
        },
      );
    }
    print('dataPosition, $dataPosition');
  }

  Marker _buildCurrentLocationMarker() {
    print('_currentPositionnnn, $_currentPosition');
    return Marker(
      markerId: MarkerId('currentLocation'),
      position: _currentPosition!,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: 'Your Location'),
    );
  }

//tessssssssssssssst de dem  in
  Future<void> _generateMarkers() async {
    _markers.clear(); // Clear existing markers
    for (int i = 0; i < dataPosition.length; i++) {
      BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(5, 5)),
        dataPosition[i]['assetPath'],
      );
      _markers[i.toString()] = Marker(
        markerId: MarkerId(i.toString()),
        position: dataPosition[i]['position'],
        icon: markerIcon,
      );
    }
    print('_markers, $_markers finMarkers');

    setState(() {}); // Update the markers once
  }

  void calculerDistances() async {
    await _generateMarkers(); // Wait for markers to be generated
    print('Distance entrkm');

    LatLng? currentPos = _currentPosition;
    double distanceMinimale = double.infinity;
    print('Distance _markers ${_markers} km');

    for (int i = 0; i < positions.length; i++) {
      try {
        double latitude = double.parse(positions[i]['latitude']);
        double longitude = double.parse(positions[i]['longitude']);

        double distance = await getDistance(
          currentPos!,
          LatLng(latitude, longitude),
        );

        print(
          'Distance entre Tenes et ${positions[i]['chauffeur_id']} : $distance km',
        );

        if (distance < distanceMinimale && distance > 0) {
          // Check for valid and positive distances
          distanceMinimale = distance;
        }
      } catch (e) {
        print(
            'Error calculating distance for ${positions[i]['chauffeur_id']}: $e');
      }
    }

    print('La distance minimale : $distanceMinimale km');
  }

  Future<double> getDistance(LatLng startCoords, LatLng endCoords) async {
    try {
      String apiKey = 'AIzaSyABw-J_9Weu9yHhveob-0tcBV4ZlCz8vkM1';
      String baseUrl =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${startCoords.latitude},${startCoords.longitude}&destination=${endCoords.latitude},${endCoords.longitude}&key=$apiKey';

      var response = await http.get(Uri.parse(baseUrl));
      //print('API Responseeee for distance calculation: ${response.body}');

      if (response.statusCode == 200) {
        print('response reussiteee');
        var data = json.decode(response.body);
        if (data['routes'] != null &&
            data['routes'].isNotEmpty &&
            data['routes'][0]['legs'] != null &&
            data['routes'][0]['legs'].isNotEmpty &&
            data['routes'][0]['legs'][0]['distance'] != null &&
            data['routes'][0]['legs'][0]['distance']['value'] != null) {
          print('response reussiteeeiiif');
          double distanceValue = double.parse(data['routes'][0]['legs'][0]
                      ['distance']['value']
                  .toString()) /
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
    } catch (e) {
      print('Error in getDistance: $e');
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
        markers: {
          ..._markers.values,
          if (_currentPosition != null) _buildCurrentLocationMarker()
        },
      ),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart'; // Importez cette ligne
import 'package:weslini/backend/utils.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(36.757574, 3.448430);
  LatLng? _currentPosition;

  List<Map<String, dynamic>> positions = [];
  bool isLoading = false;

  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    fetchPositions();
    _getCurrentLocation();
    super.initState();
  }

  List<Map<String, dynamic>> dataPosition = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) =>
            _mapController.complete(controller),
        initialCameraPosition: CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
        markers: {
          ..._markers.values,
          if (_currentPosition != null) _buildCurrentLocationMarker()
        },
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    LocationData? locationData;

    try {
      var location = Location();
      locationData = await location.getLocation();
    } catch (e) {
      print('Error getting location: $e');
    }

    if (locationData != null) {
      setState(() {
        _currentPosition =
            LatLng(locationData!.latitude!, locationData.longitude!);
      });
    } else {
      print('Error: Location data is null.');
    }
  }

  Future<void> fetchPositions() async {
    print('hhhhhhhhh');
    try {
      final response =
          await http.get(Uri.parse('${Utils.baseUrl}/user/positions'));
      print('ssssssssss');

      if (response.statusCode == 200) {
        print('ccccccc');

        final dynamic responseData = jsonDecode(response.body);

        if (responseData != null && responseData['success']) {
          setState(() {
            positions = (responseData['positions'] as List<dynamic>)
                .cast<Map<String, dynamic>>();
            _generateDataPosition();
            _generateMarkers();
            print('positionsss, $positions');
          });
        } else {
          print('Failed to fetch positions1');
        }
      } else {
        print('Failed to fetch positions2');
      }
    } catch (error) {
      print('Error fetching positions: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _generateMarkers() async {
    for (int i = 0; i < dataPosition.length; i++) {
      BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(5, 5)),
        dataPosition[i]['assetPath'],
      );
      _markers[i.toString()] = Marker(
        markerId: MarkerId(i.toString()),
        position: dataPosition[i]['position'],
        icon: markerIcon,
      );
    }
    print('_markers, $_markers finMarkers');

    setState(() {}); // Update the markers once
  }

  _generateDataPosition() {
    for (int i = 0; i < positions.length; i++) {
      double latitude = double.parse(positions[i]['latitude']);
      double longitude = double.parse(positions[i]['longitude']);

      dataPosition.add(
        {
          'id': i,
          'position': LatLng(latitude, longitude),
          'assetPath': 'assets/icon/car.png',
        },
      );
    }
    print('dataPosition, $dataPosition');
  }

  Marker _buildCurrentLocationMarker() {
    return Marker(
      markerId: MarkerId('currentLocation'),
      position: _currentPosition!,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: 'Your Location'),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 10,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }
}
//////le vrai est en haut7

*/
