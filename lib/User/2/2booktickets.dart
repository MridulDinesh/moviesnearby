import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moviesnearby/User/2/movie2.dart';
import 'package:moviesnearby/User/2/movie1.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Movie2booking extends StatefulWidget {
  const Movie2booking({super.key});

  @override
  State<Movie2booking> createState() => _Movie2bookingState();
}

class _Movie2bookingState extends State<Movie2booking> {


  final TextEditingController _numberOfTicketControllermovie2show1 = TextEditingController();
  final TextEditingController _numberOfTicketControllermovie2show2 = TextEditingController();
  final TextEditingController _numberOfTicketController11 = TextEditingController();
  final TextEditingController _numberOfTicketController22 = TextEditingController();



  late int remainingTicketsmovie2show1;
  late int remainingTicketsmovie2show2;
  int remainingTickets11 = 100;
  int remainingTickets22 = 100;// Initial value of the counter
  @override
  void initState() {
    super.initState();
    remainingTicketsmovie2show1 = 100;
    remainingTicketsmovie2show2 = 100;// Set remainingTickets to 100 when the widget initializes
    _loadRemainingTickets(); // Load remainingTickets from shared preferences
  }

  Future<void> _loadRemainingTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      remainingTicketsmovie2show1 = prefs.getInt('remainingTicketsmovie2show1') ?? remainingTicketsmovie2show1;
      remainingTicketsmovie2show2 = prefs.getInt('remainingTicketsmovie2show2') ?? remainingTicketsmovie2show2;// Use shared preferences value if available
    });
  }
  @override

  Widget build(BuildContext context) {
    return MaterialApp(home: DefaultTabController(
        length: 2,
        child: Scaffold(appBar: AppBar(title: Center(child: Text('Manjummal Boys')),actions: [TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Movie2()));
        }, child: Text('Back'))],
          bottom:TabBar(tabs: [
            Tab(text: 'April 4',),
            Tab(text: 'April 5',),
          ],) ,),
            body: TabBarView(
                children: [

                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Emax Cinemas Dolby Atmos Calicut',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog21(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.2,
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
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog22(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '1:15PM',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '2:00PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '4:15PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '5:15PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '6:45PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'Regal Cinemas: Kozhikode',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog11(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.2,
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
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog22(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '1:15PM',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '2:00PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '4:15PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '5:15PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '6:45PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Emax Cinemas Dolby Atmos Calicut',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog21(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.2,
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
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog21(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '1:15PM',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '2:00PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '4:15PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '5:15PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '6:45PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'Regal Cinemas: Kozhikode',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog11(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.2,
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
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog22(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '1:15PM',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '2:00PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '4:15PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '5:15PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '6:45PM',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                ]
            )
        )
    )
    );
  }
  void _showAlertDialog21(BuildContext context) {
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
                  Text('Remaining Tickets: $remainingTicketsmovie2show1'),
                  TextField(
                    controller: _numberOfTicketControllermovie2show1,
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
                    String numberOfTickets = _numberOfTicketControllermovie2show1.text.trim();
                    int tickets = int.tryParse(numberOfTickets) ?? 0;

                    if (tickets > 0 && tickets <= remainingTicketsmovie2show1) {
                      // Get current user ID
                      String? userId = FirebaseAuth.instance.currentUser?.uid;

                      // Update Firestore with ticket details
                      await _saveDataToFirestore21(numberOfTickets, userId);

                      // Decrement the remaining tickets counter
                      setState(() {
                        remainingTicketsmovie2show1 -= tickets;
                      });

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

  Future<void> _saveDataToFirestore21(String numberOfTickets, String? userId) async {
    if (userId != null) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      try {
        await _firestore.collection('TICKET DETAILS').doc().set({
          'MOVIE NAME': 'Manjummal Boys',
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
    await prefs.setInt('remainingTicketsmovie2show1', remainingTicketsmovie2show1);
    await prefs.setInt('remainingTicketsmovie2show2', remainingTicketsmovie2show2);
  }

  Future<void> _resetRemainingTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('remainingTicketsmovie2show1', 100);
    await prefs.setInt('remainingTicketsmovie2show2', 100);// Set remainingTickets to 100
  }

  @override
  void dispose() {
    _resetRemainingTickets(); // Reset remainingTickets to 100 when the program is stopped
    super.dispose();
  }


  void _showAlertDialog22(BuildContext context) {
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
                  Text('Remaining Tickets: $remainingTicketsmovie2show2'),
                  TextField(
                    controller: _numberOfTicketControllermovie2show2,
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
                    String numberOfTickets = _numberOfTicketControllermovie2show2.text.trim();
                    int tickets = int.tryParse(numberOfTickets) ?? 0;

                    if (tickets > 0 && tickets <= remainingTicketsmovie2show2) {
                      // Get current user ID
                      String? userId = FirebaseAuth.instance.currentUser?.uid;

                      // Update Firestore with ticket details
                      await _saveDataToFirestore22(numberOfTickets, userId);

                      // Decrement the remaining tickets counter
                      setState(() {
                        remainingTicketsmovie2show2 -= tickets;
                      });

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

  Future<void> _saveDataToFirestore22(String numberOfTickets, String? userId) async {
    if (userId != null) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      try {
        await _firestore.collection('TICKET DETAILS').doc().set({
          'MOVIE NAME': 'Manjummal Boys',
          'Date': 'April 4',
          'time': '1:15PM',
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

  void _showAlertDialog11(BuildContext context) {
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
                  Text('Remaining Tickets: $remainingTickets11'),
                  TextField(
                    controller: _numberOfTicketController11,
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
                    String numberOfTickets = _numberOfTicketController11.text.trim();
                    int tickets = int.tryParse(numberOfTickets) ?? 0;

                    if (tickets > 0 && tickets <= remainingTickets11) {
                      // Get current user ID
                      String? userId = FirebaseAuth.instance.currentUser?.uid;

                      // Update Firestore with ticket details
                      await _saveDataToFirestore11(numberOfTickets, userId);

                      // Decrement the remaining tickets counter
                      setState(() {
                        remainingTickets11 -= tickets;
                      });


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


  Future<void> _saveDataToFirestore11(String numberOfTickets, String? userId) async {
    if (userId != null) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      try {
        await _firestore.collection('TICKET DETAILS').doc().set({
          'MOVIE NAME': 'Manjummal Boys',
          'Date': 'April 4',
          'time': '10:30AM',
          'Number of tickets': numberOfTickets,
          'User ID': userId,
          'Theatre Name': 'Regal Kozhikode', // Add the theatre name field
        });
      } catch (error) {
        print('Error saving data to Firestore: $error');
      }
    } else {
      print('User ID is null');
    }
  }


  void _showAlertDialog2222(BuildContext context) {
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
                  Text('Remaining Tickets: $remainingTickets22'),
                  TextField(
                    controller: _numberOfTicketController22,
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
                    String numberOfTickets = _numberOfTicketController22.text.trim();
                    int tickets = int.tryParse(numberOfTickets) ?? 0;

                    if (tickets > 0 && tickets <= remainingTickets22) {
                      // Get current user ID
                      String? userId = FirebaseAuth.instance.currentUser?.uid;

                      // Update Firestore with ticket details
                      await _saveDataToFirestore22(numberOfTickets, userId);

                      // Decrement the remaining tickets counter
                      setState(() {
                        remainingTickets22 -= tickets;
                      });



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

  Future<void> _saveDataToFirestore2222(String numberOfTickets, String? userId) async {
    if (userId != null) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      try {
        await _firestore.collection('TICKET DETAILS').doc().set({
          'MOVIE NAME': 'Manjummal Boys',
          'Date': 'April 4',
          'time': '1:15PM',
          'Number of tickets': numberOfTickets,
          'User ID': userId,
          'Theatre Name': 'Regal Kozhikode', // Add the theatre name field
        });
      } catch (error) {
        print('Error saving data to Firestore: $error');
      }
    } else {
      print('User ID is null');
    }
  }

}




