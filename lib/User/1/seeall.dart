import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckboxModel extends ChangeNotifier {
  bool? showMalayalam = false;
  bool? showEnglish = false;
  bool? showHindi = false;

  void setShowMalayalam(bool value) {
    showMalayalam = value;
    notifyListeners();
  }

  void setShowEnglish(bool value) {
    showEnglish = value;
    notifyListeners();
  }

  void setShowHindi(bool value) {
    showHindi = value;
    notifyListeners();
  }
}

class CheckboxExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckboxModel(),
      child: _CheckboxExample(),
    );
  }
}

class _CheckboxExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final checkboxModel = Provider.of<CheckboxModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('All Movies'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CheckboxListTile(
              title: Text('Malayalam'),
              value: checkboxModel.showMalayalam,
              onChanged: (value) {
                checkboxModel.setShowMalayalam(value ?? false);
              },
            ),
            CheckboxListTile(
              title: Text('English'),
              value: checkboxModel.showEnglish,
              onChanged: (value) {
                checkboxModel.setShowEnglish(value ?? false);
              },
            ),
            CheckboxListTile(
              title: Text('Hindi'),
              value: checkboxModel.showHindi,
              onChanged: (value) {
                checkboxModel.setShowHindi(value ?? false);
              },
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (checkboxModel.showMalayalam == true)
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
                  if (checkboxModel.showEnglish == true)
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
                  if (checkboxModel.showHindi == true)
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
