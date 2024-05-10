import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviesnearby/Admin/1/AddMovies.dart';
import 'package:moviesnearby/Admin/1/Update.dart';
import 'package:moviesnearby/Admin/login.dart';
import 'package:moviesnearby/User/login.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Mylogin()));
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
        title: Text('Admin Home'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          ViewCredentialsPage(),
          ViewTicketsPage(),
          Addmoviedetails(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'View Credentials',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_sharp),
            label: 'View Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Movies',
          ),
        ],
      ),
    );
  }
}

class ViewCredentialsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AdminUpdateHome()));
          },
          child: Text(
            'View Credentials',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.08, // Adjust font size based on screen width
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class ViewTicketsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('TICKET_DETAILS').snapshots(),
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
                    'User ID: ${data['userId']}',
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: MediaQuery.of(context).size.width * 0.04, // Adjust font size based on screen width
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${data['date']}',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: MediaQuery.of(context).size.width * 0.035, // Adjust font size based on screen width
                        ),
                      ),
                      Text(
                        'Time: ${data['time']}',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: MediaQuery.of(context).size.width * 0.035, // Adjust font size based on screen width
                        ),
                      ),
                      Text(
                        'Theatre Name: ${data['theatre']}',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: MediaQuery.of(context).size.width * 0.035, // Adjust font size based on screen width
                        ),
                      ),
                      Text(
                        'Movie Name: ${data['movieName']}',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: MediaQuery.of(context).size.width * 0.035, // Adjust font size based on screen width
                        ),
                      ),
                      Text(
                        'Number of Tickets: ${data['numberOfTickets']}',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: MediaQuery.of(context).size.width * 0.035, // Adjust font size based on screen width
                        ),
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
