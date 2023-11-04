import 'package:flutter/material.dart';

class FormFields extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String txtHint;
  final bool obsecure; // Mark as final

  FormFields({
    Key? key,
    required this.controller,
    required this.data,
    required this.txtHint,
    required this.obsecure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        maxLength: 10,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFEC6294)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: txtHint,
          alignLabelWithHint: true,
          labelStyle: TextStyle(
            color: Color(0xFF979797),
          ),
        ),
        controller: controller,
        obscureText: obsecure,
      ),
    );
  }
}
