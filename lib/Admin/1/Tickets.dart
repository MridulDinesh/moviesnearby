import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviesnearby/Admin/1/adminhome.dart';


class TicketDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationPage()));
        }, icon: Icon(Icons.exit_to_app))
      ],
        title: Text('Ticket Details'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('TICKET DETAILS').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return Card(
                color: Colors.yellowAccent, // Set card color to red
                child: ListTile(
                  title: Text(
                    'User ID: ${data['User ID']}',
                    style: TextStyle(color: Colors.brown), // Set text color to black
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${data['Date']}',
                        style: TextStyle(color: Colors.brown), // Set text color to black
                      ),
                      Text(
                        'Time: ${data['time']}',
                        style: TextStyle(color: Colors.brown), // Set text color to black
                      ),
                      Text(
                        'Theatre Name: ${data['Theatre Name']}',
                        style: TextStyle(color: Colors.brown), // Set text color to black
                      ),
                      Text(
                        'Movie Name: ${data['MOVIE NAME']}',
                        style: TextStyle(color: Colors.brown), // Set text color to black
                      ),
                      Text(
                        'Number of Tickets: ${data['Number of tickets']}',
                        style: TextStyle(color: Colors.brown), // Set text color to black
                      ),
                    ],
                  ),
                  // You can add more details here if needed
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
