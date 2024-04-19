import 'package:flutter/material.dart';
import 'package:moviesnearby/User/2/2booktickets.dart';
import 'package:moviesnearby/User/1/userhome.dart';


class Movie2 extends StatefulWidget {
  const Movie2({Key? key}) : super(key: key);

  @override
  State<Movie2> createState() => _Movie2State();
}

class _Movie2State extends State<Movie2> {
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
              child: Image.asset('assets/images/movie2.jpeg'),
            ),
            Image.asset('assets/images/container2.jpeg'),
            Divider(),
            Text(
              "A group of friends get into a daring rescue mission ",
            ),
            if (_expanded)
              Text(
                " to save their friend from Guna Caves, a perilously deep pit from where nobody has ever been brought back.",
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
    Text('Kishore Kumar'),
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
    'The Malayalam film industry is experiencing a period of remarkable success this year, with the release of several notable and critically acclaimed films. Among these, "Manjummel Boys" stands out as a particularly exceptional cinematic experience, delivering an unparalleled theatrical journey.',
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
    Text('Aswin'),
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
    'Manjummel Boys, directed by the talented filmmaker, captures the essence of friendship, resilience, and the human spirit in a profoundly moving narrative. Set against the backdrop of the quaint village of Manjummel, the film takes viewers on an emotional journey that lingers long after the credits roll.',
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
    Text('Rekha'),
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
    'Manjummel Boys, directed by the talented filmmaker, captures the essence of friendship, resilience, and the human spirit in a profoundly moving narrative. Set against the backdrop of the quaint village of Manjummel, the film takes viewers on an emotional journey that lingers long after the credits roll.',
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
    )])),


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
                      backgroundImage: AssetImage('assets/images/movie2cast1.jpg'),
                    ),
                    Text('Soubin Shahir'),
                    Text('As Siju'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2cast2.jpg'),
                    ),
                    Text('Sreenath Bhasi'),
                    Text('As Subash'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2cast3.jpg'),
                    ),
                    Text('Balu Varghese'),
                    Text('As John'),


                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2cast5.jpg'),
                    ),
                    Text('Ganapathy'),
                    Text('As Krishnakumar'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2cast7.jpg'),
                    ),
                    Text('Deepak Parambol'),
                    Text('As Sudheesh'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2cast4.jpg'),
                    ),
                    Text('Abhiram Radhakrishna'),
                    Text('As Anil'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2cast6.jpg'),
                    ),
                    Text('Jean Paul'),
                    Text('As Jiju John'),

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
                children: [

                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2crew1.jpg'),
                    ),
                    Text('Chidambaram'),
                    Text('Director'),                    Text('Screenplay'),


                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2crew2.jpg'),
                    ),
                    Text('Shyju Khalid'),
                    Text('Cinematographer'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2cast1.jpg'),
                    ),
                    Text('Soubin Shahir'),
                    Text('Producer'),


                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2crew5.jpg'),
                    ),
                    Text('Shawn Antony'),
                    Text('Action Director'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2crew4.jpg'),
                    ),
                    Text('Babu Shahir'),
                    Text('Producer'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2crew3.jpg'),
                    ),
                    Text('Sushin Shyam'),
                    Text('Musician'),

                  ],),
                  Column(children: [
                    CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Set background color to transparent for circular avatar
                      backgroundImage: AssetImage('assets/images/movie2crew7.jpg'),
                    ),
                    Text('Vivek Harshan'),
                    Text('Editor'),

                  ],)
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Movie2booking()));
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
