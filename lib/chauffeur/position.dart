import 'dart:convert';

import 'package:flutter/material.dart';
import 'position.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class position extends StatefulWidget {
  const position({super.key});

  @override
  State<position> createState() => _positionState();
}

class _positionState extends State<position> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Location Tracker')),
        body: FutureBuilder<List<Location>>(
          future: LocationService().fetchLocations(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final locations = snapshot.data!;
              return ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  final location = locations[index];
                  return ListTile(
                    title: Text(
                        'Latitude: ${location.latitude}, Longitude: ${location.longitude}'),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error fetching locations');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final location = await LocationService().getCurrentLocation();
            await LocationService()
                .storeLocation(location.latitude, location.longitude);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});
}

class LocationService {
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> storeLocation(double latitude, double longitude) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/store-location'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'latitude': latitude, 'longitude': longitude}),
    );

    if (response.statusCode == 200) {
      print('Location stored successfully');
    } else {
      print('Error storing location');
    }
  }

  Future<List<Location>> fetchLocations() async {
  final response = await http.get(Uri.parse('http://localhost:3000/get-locations'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    final List<Location> locations = data.map((location) {
      return Location(
        latitude: location['latitude'],
        longitude: location['longitude'],
      );
    }).toList();
    return locations;
  } else {
    throw Exception('Failed to fetch locations');
  }
}

}
