import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded1 = false;
  bool isExpanded2 = false;

  void toggleExpand1() {
    setState(() {
      isExpanded1 = !isExpanded1;
    });
  }

  void toggleExpand2() {
    setState(() {
      isExpanded2 = !isExpanded2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEC6294),
        title: Text(
          "Question fréquentes",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.all(10.0), // Adjust the margin as needed
            padding: EdgeInsets.all(20.0), // Add padding as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color.fromARGB(255, 240, 238, 238)
                    .withOpacity(5.0), // Border color
                width: 1.0, // Border width
              ), // Adjust the radius as needed
              boxShadow: [
                BoxShadow(
                  color: Colors.white, // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  // Offset in x and y directions
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'This is the initial text 1.',
                      style: TextStyle(
                          color: Color(0xFF8C8C8C),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: toggleExpand1,
                      child: Icon(
                        isExpanded1 ? Icons.remove_circle : Icons.add_circle,
                        color: Color(0xFFEC6294),
                      ),
                    ),
                  ],
                ),
                isExpanded1
                    ? Text(
                        'This is the expanded text 1 that appears when you click on the plus icon. You can add more content here.',
                        style:
                            TextStyle(fontSize: 14.0, color: Color(0xFF8C8C8C)),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0), // Adjust the margin as needed
            padding: EdgeInsets.all(20.0), // Add padding as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xFF8C8C8C), // Border color
                width: 1.0, // Border width
              ), // Adjust the radius as needed
              boxShadow: [
                BoxShadow(
                  color: Colors.white, // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 2, // Blur radius
                  // Offset in x and y directions
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'This is the initial text 2.',
                      style: TextStyle(
                          color: Color(0xFF8C8C8C),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: toggleExpand2,
                      child: Icon(
                        isExpanded2 ? Icons.remove : Icons.add,
                        color: Color(0xFFEC6294),
                      ),
                    ),
                  ],
                ),
                isExpanded2
                    ? Text(
                        'This is the expanded text 1 that appears when you click on the plus icon. You can add more content here.',
                        style:
                            TextStyle(fontSize: 14.0, color: Color(0xFF8C8C8C)),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
