import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviesnearby/User/1/userhomee.dart';
import 'package:moviesnearby/User/1/userprofilee.dart';
import 'package:moviesnearby/User/login.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  // Text editing controllers for the input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Variable to store the current user ID
  String? currentUserID;

  @override
  void initState() {
    super.initState();
    getCurrentUser(); // Call a function to get the current user ID
  }

  void getCurrentUser() {
    // Retrieve the current user from FirebaseAuth
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserID = user.uid;
      });
      fetchUserDetails(); // Fetch user details when the screen loads
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TextFields to display user details
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 16.0),
              // Submit button
              ElevatedButton(
                onPressed: () {
                  updateUserDetails();
                },
                child: Text('Change'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to fetch user details from Firestore
  void fetchUserDetails() {
    if (currentUserID != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserID)
          .get()
          .then((doc) {
        if (doc.exists) {
          // Populate text fields with user details
          setState(() {
            _nameController.text = doc['name'];
            _emailController.text = doc['email'];
            _phoneController.text = doc['phone'];
            _addressController.text = doc['address'];
          });
        }
      });
    }
  }

  // Function to update user details in Firestore
  void updateUserDetails() {
    if (currentUserID != null) {
      FirebaseFirestore.instance.collection('users').doc(currentUserID).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User details updated successfully')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user details: $error')),
        );
      });
    }
  }
}
