import 'package:flutter/material.dart';
import 'package:moviesnearby/Admin/login.dart';
import 'package:moviesnearby/User/login.dart';
import 'package:moviesnearby/User/signup.dart';

class Myhome extends StatelessWidget {
  const Myhome({Key? key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.jpg', // Change this path to your background image
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5),
                ),
                height: screenSize.height * 0.15, // Adjusted height based on screen height
                width: screenSize.width * 0.8, // Adjusted width based on screen width
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Mylogin()));
                  },
                  child: Text('Get Started',style: TextStyle(color: Colors.red,fontSize: 40),),
                ),
              ),
              SizedBox(height: screenSize.height * 0.05), // Adjusted height based on screen height

            ],
          ),
        ],
      ),
    );
  }
}
