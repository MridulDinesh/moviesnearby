import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:moviesnearby/User/2/movie.dart';
import 'package:moviesnearby/User/login.dart';
import 'package:moviesnearby/User/1/seeall.dart';
import 'package:url_launcher/url_launcher.dart';

class Userhome extends StatefulWidget {
  const Userhome({Key? key}) : super(key: key);

  @override
  State<Userhome> createState() => _UserhomeState();
}

class _UserhomeState extends State<Userhome> {
  int _currentIndex2 = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
            stops: [0.0, 0.7]
        )
      ),
        child: SingleChildScrollView(
          child: Column(
            children: [

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
                      _currentIndex2 = index;
                    });
                  },
                ),
              ),
              DotsIndicator(
                dotsCount: 2,
                position: _currentIndex2.toInt(),
                decorator: DotsDecorator(
                    color: Colors.grey, activeColor: Colors.blue),
              ),
              SizedBox(width: 140
                  ,child: Divider(color: Colors.black,)),
              Text("Recommended Movies",style: TextStyle(fontSize: 20),),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('films2').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
          
                        return Row(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Movie(documentId: document.id)));

                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                height: 170,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    data['poster'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(width: 250
                  ,child: Divider(color: Colors.black,)),
              GestureDetector(
                onTap: () {
                  _launchURL('https://www.primevideo.com/offers/nonprimehomepage/ref=dv_web_force_root');
                },
                child: Image.asset('assets/images/amazon.jpg'),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
