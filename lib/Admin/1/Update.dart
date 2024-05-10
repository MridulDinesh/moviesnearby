import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviesnearby/Admin/1/UpdateDetails.dart';
import 'package:moviesnearby/Admin/1/adminhome.dart';

class AdminUpdateHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationPage()));
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
        title: Text('Credential Data'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              String email = data['email'] ?? ''; // Provide default value if email is null
              String address = data['address'] ?? ''; // Provide default value if address is null
              String phone = data['phone'] ?? ''; // Provide default value if phone is null

              return ListTile(
                title: Text(
                  email,
                  style: TextStyle(fontSize: screenSize.width * 0.04), // Adjust font size based on screen width
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address: $address',
                      style: TextStyle(fontSize: screenSize.width * 0.035), // Adjust font size based on screen width
                    ),
                    Text(
                      'Phone: $phone',
                      style: TextStyle(fontSize: screenSize.width * 0.035), // Adjust font size based on screen width
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Update(
                              documentId: document.id,
                              email: email,
                              address: address,
                              phone: phone,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirm Delete"),
                              content: Text("Are you sure you want to delete this user?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance.collection('users').doc(document.id).delete();
                                    Navigator.pop(context);
                                  },
                                  child: Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
