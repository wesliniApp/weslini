import 'package:flutter/material.dart';
import 'package:weslini/home.dart';

void main() {
  runApp(MyApp());
}

//stateleess static data mchi button wlaa that text des images c tt
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //pour enlever sharit a cote
      home: Home(),
    );
  }
}
