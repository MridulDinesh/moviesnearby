import 'package:flutter/material.dart';

class CheckboxExample extends StatefulWidget {
  @override
  _CheckboxExampleState createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool? showMalayalam = false;
  bool? showEnglish = false;
  bool? showHindi = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('All Movies'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CheckboxListTile(
              title: Text('Malayalam'),
              value: showMalayalam,
              onChanged: (bool? value) {
                setState(() {
                  showMalayalam = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text('English'),
              value: showEnglish,
              onChanged: (bool? value) {
                setState(() {
                  showEnglish = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Hindi'),
              value: showHindi,
              onChanged: (bool? value) {
                setState(() {
                  showHindi = value;
                });
              },
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showMalayalam == true)
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Image.asset(
                            'assets/images/mov1.jpeg',
                            height: screenWidth * 0.4 * 1.5, // Adjusted height
                            fit: BoxFit.contain, // Adjusted fit
                          ),
                        ),
                        SizedBox(width: 20), // Add space between images
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Image.asset(
                            'assets/images/mov6.jpeg',
                            height: screenWidth * 0.4 * 1.5, // Adjusted height
                            fit: BoxFit.contain, // Adjusted fit
                          ),
                        ),
                      ],
                    ),
                  if (showEnglish == true)
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Image.asset(
                            'assets/images/mov2.jpeg',
                            height: screenWidth * 0.4 * 1.5, // Adjusted height
                            fit: BoxFit.contain, // Adjusted fit
                          ),
                        ),
                        SizedBox(width: 20), // Add space between images
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Image.asset(
                            'assets/images/mov3.jpeg',
                            height: screenWidth * 0.4 * 1.5, // Adjusted height
                            fit: BoxFit.contain, // Adjusted fit
                          ),
                        ),
                        SizedBox(width: 20), // Add space between images
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Image.asset(
                            'assets/images/mov4.jpeg',
                            height: screenWidth * 0.4 * 1.5, // Adjusted height
                            fit: BoxFit.contain, // Adjusted fit
                          ),
                        ),
                      ],
                    ),
                  if (showHindi == true)
                    SizedBox(
                      width: screenWidth * 0.4,
                      child: Image.asset(
                        'assets/images/mov5.jpeg',
                        height: screenWidth * 0.4 * 1.5, // Adjusted height
                        fit: BoxFit.contain, // Adjusted fit
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
