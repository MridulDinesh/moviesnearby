import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mysample extends StatefulWidget {
  const Mysample({Key? key}) : super(key: key);

  @override
  State<Mysample> createState() => _MysampleState();
}

class _MysampleState extends State<Mysample> {
  final TextEditingController _numberOfTicketController = TextEditingController();
  late int remainingTickets;

  @override
  void initState() {
    super.initState();
    remainingTickets = 100; // Set remainingTickets to 100 when the widget initializes
    _loadRemainingTickets(); // Load remainingTickets from shared preferences
  }

  Future<void> _loadRemainingTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      remainingTickets = prefs.getInt('remainingTickets') ?? remainingTickets; // Use shared preferences value if available
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 200)),
          GestureDetector(
            onTap: () {
              _showAlertDialog(context);
            },
            child: Container(
              height: 50,
              width: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  '10:30AM',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Enter Number of Tickets'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Remaining Tickets: $remainingTickets'),
                  TextField(
                    controller: _numberOfTicketController,
                    decoration: InputDecoration(hintText: 'Number of Tickets'),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    String numberOfTickets = _numberOfTicketController.text.trim();
                    int tickets = int.tryParse(numberOfTickets) ?? 0;

                    if (tickets > 0 && tickets <= remainingTickets) {
                      // Get current user ID
                      String? userId = FirebaseAuth.instance.currentUser?.uid;

                      // Update Firestore with ticket details
                      await _saveDataToFirestore(numberOfTickets, userId);

                      // Decrement the remaining tickets counter
                      setState(() {
                        remainingTickets -= tickets;
                      });

                      // Save the updated remaining tickets count
                      await _updateRemainingTickets();

                      // Close the AlertDialog
                      Navigator.of(context).pop();
                    } else {
                      // Show an error message if the entered number of tickets is invalid
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Invalid number of tickets!'),
                      ));
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _saveDataToFirestore(String numberOfTickets, String? userId) async {
    if (userId != null) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      try {
        await _firestore.collection('TICKET DETAILS').doc().set({
          'MOVIE NAME': 'Aadujeevitham',
          'Date': 'April 4',
          'time': '10:30AM',
          'Number of tickets': numberOfTickets,
          'User ID': userId,
          'Theatre Name': 'Emax Calicut', // Add the theatre name field
        });
      } catch (error) {
        print('Error saving data to Firestore: $error');
      }
    } else {
      print('User ID is null');
    }
  }

  Future<void> _updateRemainingTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('remainingTickets', remainingTickets);
  }

  Future<void> _resetRemainingTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('remainingTickets', 100); // Set remainingTickets to 100
  }

  @override
  void dispose() {
    _resetRemainingTickets(); // Reset remainingTickets to 100 when the program is stopped
    super.dispose();
  }
}

