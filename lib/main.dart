import 'package:flutter/material.dart';
import 'package:weslini/passager.dart';

void main() {
  runApp(xapp());
}

//stateleess static data mchi button wlaa that text des images c tt
class xapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //pour enlever sharit a cote
      home: Passager(),
    );
  }
}
