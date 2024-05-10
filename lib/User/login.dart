import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moviesnearby/Admin/1/adminhome.dart';
import 'package:moviesnearby/User/1/userhome.dart';
import 'package:moviesnearby/User/1/userhomee.dart';
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

  @override
  void initState() {
    super.initState();
    _getEmailFromSharedPreferences().then((email) {
      if (email != null) {
        _emailController.text = email;
      }
    });
  }

  Future<void> _signIn(BuildContext context) async {
    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save email to shared preferences
      await _saveEmailToSharedPreferences(email);

      // Check if the entered credentials belong to the admin
      if (userCredential.user != null && userCredential.user!.email == "admin@gmail.com") {
        // Navigate to admin page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationPage()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-in Successful')),
        );
      } else {
        // If not admin, navigate to user home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserBottomNavigationPage()),
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

  Future<void> _saveEmailToSharedPreferences(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<String?> _getEmailFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,backgroundColor: Colors.black,
        title: Text('Movies Nearby',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.white],
              stops: [0.0, 0.7], // Adjust stops as needed
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(padding: EdgeInsets.only(top: 150)),
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

                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(

                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.lock, color: Colors.blue),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ElevatedButton(
                    onPressed: () => _signIn(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // background color
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // text color
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)), // button padding
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // button border radius
                        ),
                      ),
                    ),
                    child: Text(
                      'Log In',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EmailAndPassword()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // background color
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // text color
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)), // button padding
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // button border radius
                        ),
                      ),
                    ),
                    child: Text('Don\'t have an account?'),

                  ),
                  SizedBox(height: 10,),
                  TextButton(
                      onPressed: () async {
                        try {
                          // Sign in with Google
                          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                          if (googleUser != null) {
                            final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                            final AuthCredential credential = GoogleAuthProvider.credential(
                              accessToken: googleAuth.accessToken,
                              idToken: googleAuth.idToken,
                            );

                            // Sign in to Firebase with Google credentials
                            final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

                            // Navigate to the user home page
                            if (userCredential.user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UserBottomNavigationPage()),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Sign-in Successful with Google')),
                              );
                            }
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to sign in with Google: $e')),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          SizedBox(width:70 ,),

                          Text('Sign In with Google',style: TextStyle(color: Colors.black),),
                          SizedBox(width:10 ,),
                          Image.asset('assets/images/google.png',height: 20,width: 20,)
                        ],
                      )
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}