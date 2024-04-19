import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:moviesnearby/User/login.dart';
import 'package:moviesnearby/User/2/movie2.dart';
import 'package:moviesnearby/User/2/movie1.dart';
import 'package:moviesnearby/User/1/seeall.dart';

class Userhome extends StatefulWidget {
  const Userhome({Key? key}) : super(key: key);

  @override
  State<Userhome> createState() => _UserhomeState();
}

class _UserhomeState extends State<Userhome> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Mylogin()));
            },
            child: Text('Logout'),
          ),
        ],
        title: Text('Movies Nearby'),
      ),
      body: Column(
        children: [
          Divider(),
          CarouselSlider(
            items: [
              Image.asset('assets/images/carou1.png'),
              Image.asset('assets/images/carou2.png'),
            ],
            options: CarouselOptions(
              height: screenHeight * 0.3, // Adjusted height based on screen size
              enlargeCenterPage: true,
              autoPlay: true,
              enableInfiniteScroll: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: Duration(milliseconds: 700),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          DotsIndicator(
            dotsCount: 2,
            position: _currentIndex.toInt(),
            decorator: DotsDecorator(
                color: Colors.grey, activeColor: Colors.blue),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Text('Recommended Movies'),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CheckboxExample()));
                  },
                  child: Text('See All'),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [






                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Movie1()));
                  },
                  child: Image.asset('assets/images/mov1.jpeg', height: screenHeight * 0.4, width: screenWidth * 0.3),
                ),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Movie2()));
                  },
                  child: Image.asset('assets/images/mov6.jpeg', height: screenHeight * 0.4, width: screenWidth * 0.3),
                ),
                SizedBox(width: 20,),
                Image.asset('assets/images/mov2.jpeg', height: screenHeight * 0.4, width: screenWidth * 0.3),SizedBox(width: 20,),
                Image.asset('assets/images/mov3.jpeg', height: screenHeight * 0.4, width: screenWidth * 0.3),SizedBox(width: 20,),
                Image.asset('assets/images/mov4.jpeg', height: screenHeight * 0.4, width: screenWidth * 0.3),SizedBox(width: 20,),
                Image.asset('assets/images/mov5.jpeg', height: screenHeight * 0.4, width: screenWidth * 0.3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
