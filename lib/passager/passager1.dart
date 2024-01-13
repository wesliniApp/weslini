import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weslini/chauffeur/chauffeurHome.dart';
import 'package:weslini/connexion/connexion.dart';
import 'package:weslini/passager/aide.dart';
import 'package:weslini/passager/passager2.dart';
import 'package:weslini/profile.dart';
import 'package:http/http.dart' as http;
import 'package:weslini/backend/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show cos, sqrt, asin, sin, pi;
import 'package:location/location.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class PassagerHome extends StatefulWidget {
  final String userType;
  final String userName;
  final String userPrenom;
  final String userEmail;
  PassagerHome({
    required this.userType,
    required this.userName,
    required this.userPrenom,
    required this.userEmail,
  });

  @override
  State<PassagerHome> createState() => _PassagerHomeState();
}

class _PassagerHomeState extends State<PassagerHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294); // Couleur grise
  late String userType;
  late String userName;
  late String userPrenom;
  late String userEmail;

  ///partie map distance depuis bdd
  ///late GoogleMapController mapController;

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
    userType = widget.userType;
    userName = widget.userName;
    userPrenom = widget.userPrenom;
    userEmail = widget.userEmail;
    // Add a call to fetchPositions and chain the execution of calculerDistances
    fetchPositions().then((_) {
      _getCurrentLocation().then((_) {
        calculerDistances();
      });
    });
    //fin partie distance
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

  //fin partie map

  Future<void> logout() async {
    final String url = '${Utils.baseUrl}/user/logout';

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        // Vous pouvez ajouter d'autres en-têtes au besoin
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['success']) {
        // Déconnexion réussie, naviguez vers l'écran de connexion par exemple
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Connexion()),
        );
      } else {
        print(responseData['message']);
      }
    } else {
      print('Échec de la déconnexion');
    }
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white, size: 30.0),
        leading: GestureDetector(
          onTap: _openDrawer,
          child: Container(
            margin: EdgeInsets.only(left: 10, top: 10),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
            ),
            child: Center(
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 16),
                    Text(
                      'Passager ',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEC6294)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Ou allez vous ?',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFFEC6294)),
                    ),
                    Container(
                      child: TextField(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FormDestination()), // Utilisez la classe de la nouvelle page
                          );
                        },
                        decoration: InputDecoration(
                          labelText: 'Votre destination',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFEC6294)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFEC6294)),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('passager'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Centre aide'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Aide()),
                );
              },
            ),
            if (userType == 'passageretchaufeur')
              Container(
                margin: EdgeInsets.only(left: 20, top: 50, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChauffeurHome()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFEC6294),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Chauffeur',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  // Appeler la fonction de déconnexion ici
                  logout();
                },
                child: Text('Se déconnecter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // Set background color here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
