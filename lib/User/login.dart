import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moviesnearby/Admin/1/adminhome.dart';
import 'package:moviesnearby/Home.dart';
import 'package:moviesnearby/User/1/userhome.dart';
import 'package:moviesnearby/User/signup.dart';
import 'package:moviesnearby/firebase_options.dart';

class Mylogin extends StatefulWidget {
  const Mylogin({Key? key}) : super(key: key);

  @override
  State<Mylogin> createState() => _MyloginInState();
}

class _MyloginInState extends State<Mylogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn(BuildContext context) async {
    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the entered credentials belong to the admin
      if (userCredential.user != null && userCredential.user!.email == "admin@gmail.com") {
        // Navigate to admin page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationPage()), // Replace BottomNavigationPage with your admin page class
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-in Successful')),
        );
      } else {
        // If not admin, navigate to user home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Userhome()), // Replace Userhome with your user home page class
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-in Successful as User')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.08),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ElevatedButton(
                onPressed: () => _signIn(context),
                child: Text('Log In'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EmailAndPassword()));
                },
                child: Text('Don\'t have an account?'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Myhome()));
                },
                child: Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
