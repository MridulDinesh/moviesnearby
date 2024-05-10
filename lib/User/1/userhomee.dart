import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:moviesnearby/Admin/1/AddMovies.dart';
import 'package:moviesnearby/Admin/1/Update.dart';
import 'package:moviesnearby/Admin/login.dart';
import 'package:moviesnearby/User/1/userhome.dart';
import 'package:moviesnearby/User/1/userprofile.dart';
import 'package:moviesnearby/User/1/userprofilee.dart';
import 'package:moviesnearby/User/1/userviewticket.dart';
import 'package:moviesnearby/User/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserBottomNavigationPage extends StatefulWidget {
  @override
  _UserBottomNavigationPageState createState() => _UserBottomNavigationPageState();
}

class _UserBottomNavigationPageState extends State<UserBottomNavigationPage> {
  int _currentIndex = 0;
  final currentUserID = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70),
        child: AppBar(backgroundColor: Colors.black,centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Mylogin()));
              },
              child: Text('Logout',style: TextStyle(color: Colors.white),),
            ),
          ],
          title: Text('Movies Nearby',style: TextStyle(color: Colors.white)),
        ),
      ),drawer: Drawer(

      child: ListView(
        children: [
          GestureDetector(onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfilePage()),
            );
          },child: ListTile(leading: Icon(Icons.account_circle),title: Text('My Account'),trailing: Icon(Icons.arrow_forward_ios_sharp),)),
          GestureDetector(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TicketDetailsScreen()));
          },child: ListTile(leading: Icon(Icons.notification_important),title: Text('Notifications'),trailing: Icon(Icons.arrow_forward_ios_sharp),)),
          ListTile(leading: Icon(Icons.settings),title: Text('Settings'),trailing: Icon(Icons.arrow_forward_ios_sharp),),
          GestureDetector(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Mylogin()));
          },child: ListTile(leading: Icon(Icons.logout),title: Text('Logout'),trailing: Icon(Icons.arrow_forward_ios_sharp),))



        ],
      ),
    ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Userhome(),
          TicketDetailsScreen(),
          UserProfilePage(),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cases_outlined),
            label: 'View Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.08, fontWeight: FontWeight.bold, color: Colors.black),
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
                    style: TextStyle(color: Colors.brown), // Set text color to black
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${data['date']}',
                        style: TextStyle(color: Colors.brown), // Set text color to black
                      ),
                      Text(
                        'Time: ${data['time']}',
                        style: TextStyle(color: Colors.brown), // Set text color to black
                      ),
                      Text(
                        'Theatre Name: ${data['theatre']}',
                        style: TextStyle(color: Colors.brown), // Set text color to black
                      ),
                      Text(
                        'Movie Name: ${data['movieName']}',
                        style: TextStyle(color: Colors.brown), // Set text color to black
                      ),
                      Text(
                        'Number of Tickets: ${data['numberOfTickets']}',
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
