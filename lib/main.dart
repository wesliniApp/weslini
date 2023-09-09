import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:weslini/passager.dart';
=======
import 'package:weslini/home.dart';
>>>>>>> cd474ccd91cfa981c77234b197f859b9e21c0663

void main() {
  runApp(xapp());
}

//stateleess static data mchi button wlaa that text des images c tt
<<<<<<< HEAD
class xapp extends StatelessWidget {
=======
class MyApp extends StatelessWidget {
>>>>>>> cd474ccd91cfa981c77234b197f859b9e21c0663
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //pour enlever sharit a cote
<<<<<<< HEAD
      home: Passager(),
=======
      home: Home(),
>>>>>>> cd474ccd91cfa981c77234b197f859b9e21c0663
    );
  }
}
