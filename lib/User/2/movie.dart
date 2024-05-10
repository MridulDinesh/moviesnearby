import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviesnearby/User/1/user_view_crew.dart';
import 'package:moviesnearby/User/1/user_view_shows.dart';
import 'package:moviesnearby/User/1/userhomee.dart';
import '../1/user_view_cast.dart';

class Movie extends StatelessWidget {
  final String documentId;

  Movie({required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => UserBottomNavigationPage()),
              );
            },
            child: Text('Back', style: TextStyle(color: Colors.white)),
          ),
        ],
        title: Text('Movie Details',style: TextStyle(color: Colors.white),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('films2').doc(documentId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;

          return data != null
              ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.white],
                stops: [0.0, 0.7], // Adjust stops as needed
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Image.network(
                      data['poster'],
                      fit: BoxFit.cover,
                      width: 200,
                      height: 300,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Movie Name: ${data['name']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Duration: ${data['duration']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Language: ${data['lang']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 23),
                    SizedBox(width: 140
                        ,child: Divider(color: Colors.black,)),
                    Text(
                      'Cast',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height:150,child: UserViewCast(docId:documentId,)),
                    SizedBox(width: 140
                        ,child: Divider(color: Colors.black,)),
                    Text(
                      'Crew',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height:150,child: UserViewCrew(docId:documentId,)),
                    SizedBox(width: 140
                        ,child: Divider(color: Colors.black,)),
                    Text(
                      'Movie Shows',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height:150,child: UserViewShow(docId:documentId,)),
                    SizedBox(height: 10,),
                    SizedBox(width: 140
                        ,child: Divider(color: Colors.black,)),
                    Text('Popular Movies',style: TextStyle(fontSize: 18),),
                    SizedBox(height:10 ,),
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
                  ],
                ),
              ),
            ),
          )
              : Text('No Data Found');
        },
      ),
    );
  }
}
