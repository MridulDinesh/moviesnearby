import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviesnearby/User/1/userhomee.dart';

class TicketDetailsScreen extends StatefulWidget {
  @override
  _TicketDetailsScreenState createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  List<Map<String, dynamic>> ticketDetails = [];
  String? currentUserID;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserID = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('TICKET_DETAILS')
            .where('userId', isEqualTo: currentUserID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No ticket details found.'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    return Card(
                      elevation: 4,
                      color: Colors.grey[10],
                      child: ListTile(
                        title: Text(
                          doc['movieName'],
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date: ${doc['date']}',
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              'Number of Tickets: ${doc['numberOfTickets']}',
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              'Theatre: ${doc['theatre']}',
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              'Time: ${doc['time']}',
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              'User ID: ${doc['userId']}',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserBottomNavigationPage()));
                },
                child: Text('Back'),
              ),
            ],
          );
        },
      ),
    );
  }
}
