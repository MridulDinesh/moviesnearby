import 'package:flutter/material.dart';
import 'package:moviesnearby/User/2/1booktickets.dart';
import 'package:moviesnearby/User/1/userhome.dart';


class Movie1 extends StatefulWidget {
  const Movie1({Key? key}) : super(key: key);

  @override
  State<Movie1> createState() => _Movie1State();
}

class _Movie1State extends State<Movie1> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Movies Nearby'),
          actions: [TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Userhome()));
          }, child: Text('Back'))]
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            GestureDetector(
              onTap: () {
                // Handle image tap action
              },
              child: Image.asset('assets/images/movie1.jpeg'),
            ),
            Image.asset('assets/images/container1.jpeg'),
            Divider(),
            Text(
              "Indian migrant worker Najeeb Muhammed goes to Saudi Arabia ",
            ),
            if (_expanded)
              Text(
                " to earn money to send back home,but he finds himself living a slave-like existence herding goats in the middle of the desert.",
              ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Text(
                _expanded ? "See less..." : "See more...",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            Text('Top Reviews'),
            SizedBox(height: 10),
    SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
    children: [
    Container(
    height: 200,
    width: MediaQuery.of(context).size.width * 0.8, // Adjust width based on screen width
    decoration: BoxDecoration(
    border: Border.all(color: Colors.black),
    ),
    child: Column(
    children: [
    Row(
    children: [
    Icon(Icons.account_circle),
    SizedBox(width: 10),
    Text('Anoob Madhu'),
    SizedBox(width: MediaQuery.of(context).size.width * 0.25), // Adjust width based on screen width
    Icon(Icons.star, color: Colors.red),
    SizedBox(width: 5),
    Text('10/10')
    ],
    ),
    SizedBox(height: 20),
    Expanded(
    child: SingleChildScrollView(
    child: Text(
    'Aadujeevitham is a spectacular and emotionally-charged movie that left a lasting impact on me. Directed by Blessy and starring the incredible Prithviraj Sukumaran, this Malayalam film tells the story of a young man named Najeeb, who is forced to leave his family in search of a better life abroad.',
    textAlign: TextAlign.justify,
    ),
    ),
    ),
    SizedBox(height: 26),
    Row(
    children: [
    Icon(Icons.thumb_up),
    SizedBox(width: 20),
    Icon(Icons.thumb_down),
    SizedBox(width: MediaQuery.of(context).size.width * 0.40), // Adjust width based on screen width
    Text('6days Ago'),
    ],
    )
    ],
    ),
    ),
    SizedBox(width: 10),
    Container(
    height: 200,
    width: MediaQuery.of(context).size.width * 0.8, // Adjust width based on screen width
    decoration: BoxDecoration(
    border: Border.all(color: Colors.black),
    ),
    child: Column(
    children: [
    Row(
    children: [
    Icon(Icons.account_circle),
    SizedBox(width: 10),
    Text('Alwin'),
    SizedBox(width: MediaQuery.of(context).size.width * 0.25), // Adjust width based on screen width
    Icon(Icons.star, color: Colors.red),
    SizedBox(width: 5),
    Text('10/10')
    ],
    ),
    SizedBox(height: 20),
    Expanded(
    child: SingleChildScrollView(
    child: Text(
    '"Aadujeevitham" is an exceptionally moving and thought-provoking film that left an indelible mark on me. Directed by Blessy and featuring stellar performances by Prithviraj Sukumaran and Amala Paul, this cinematic masterpiece is a poignant exploration of the human spirit\'s resilience in the face of unimaginable adversity.👍🏻😊',
    textAlign: TextAlign.justify,
    ),
    ),
    ),
    SizedBox(height: 10),
    Row(
    children: [
    Icon(Icons.thumb_up),
    SizedBox(width: 20),
    Icon(Icons.thumb_down),
    SizedBox(width: MediaQuery.of(context).size.width * 0.40), // Adjust width based on screen width
    Text('3days Ago'),
    ],
    )
    ],
    ),
    ),
    SizedBox(width: 10),
    Container(
    height: 200,
    width: MediaQuery.of(context).size.width * 0.8, // Adjust width based on screen width
    decoration: BoxDecoration(
    border: Border.all(color: Colors.black),
    ),
    child: Column(
    children: [
    Row(
    children: [
    Icon(Icons.account_circle),
    SizedBox(width: 10),
    Text('Jayesh Chandran'),
    SizedBox(width: MediaQuery.of(context).size.width * 0.25), // Adjust width based on screen width
    Icon(Icons.star, color: Colors.red),
    SizedBox(width: 5),
    Text('8/10')
    ],
    ),
    SizedBox(height: 20),
    Expanded(
    child: SingleChildScrollView(
    child: Text(
    '“Aadujeevitham” (The Goat Life), directed by Blessy, is a remarkable survival drama that leaves a lasting impact. Starring Prithviraj Sukumaran in the lead role, this film takes us on an emotional journey through the harsh realities of life.A Stunning Survival Drama',
    textAlign: TextAlign.justify,
    ),
    ),
    ),
    SizedBox(height: 43),
    Row(
    children: [
    Icon(Icons.thumb_up),
    SizedBox(width: 20),
    Icon(Icons.thumb_down),
    SizedBox(width: MediaQuery.of(context).size.width * 0.40), // Adjust width based on screen width
    Text('4days Ago'),
    ],
    )
    ],
    ),
    ),
    SizedBox(width: 10),
    ],
    ),),



            Divider(),
            Row(
              children: [
                Text('Cast'),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie1cast1.jpg'),
                    ),
                    Text('Prithviaj'),
                    Text('As Najeeb'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie1cast2.jpg'),
                    ),
                    Text('Amala Paul'),
                    Text('As Sainu'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie1cast3.jpg'),
                    ),
                    Text('JImmy Louis'),
                    Text('As Ibrahim Khadiri'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie1cast4.jpg'),
                    ),
                    Text('Kr Gokul'),
                    Text('As Hakkim'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie1cast5.jpg'),
                    ),
                    Text('Talib Al Balushi'),
                    Text('As Khafeel'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie1cast6.jpg'),
                    ),
                    Text('Rik Aby'),
                    Text('As Jasser'),

                  ],),
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                Text('Crew'),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [Column(children: [
                  CircleAvatar(
                    radius: 50, // Adjust the radius as needed
                    backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                    backgroundImage: AssetImage('assets/images/movie1crew1.jpg'),
                  ),
                  Text('Blessy'),
                  Text('Director'),

                ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie1crew2.jpg'),
                    ),
                    Text('AR Rahman'),
                    Text('Musician'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie1crew3.jpg'),
                    ),
                    Text('Vijay Yeshudas'),
                    Text('Singer'),


                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie1crew4.jpg'),
                    ),
                    Text('Dhilip Subbarayan'),
                    Text('Action Director'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie1crew5.jpg'),
                    ),
                    Text('Prashanth Madhav'),
                    Text('Art Director'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie1crew6.jpg'),
                    ),
                    Text('Ranjith Ambady'),
                    Text('Makeup Artist'),

                  ],),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.red,
          height: 50,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Movie1booking()));
              // Handle book tickets action
            },
            child: Center(
              child: Text(
                'Book Tickets',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
