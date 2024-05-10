import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';


class ViewTest extends StatelessWidget {
  const ViewTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("films2").snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleMovieDetailsTest(
                          movieId: snapshot.data!.docs[index].id,
                        ),
                      ),
                    );
                  },
                  leading: Text(snapshot.data!.docs[index]["duration"]),
                  title: Text(snapshot.data!.docs[index]["name"]),
                  trailing: Text(snapshot.data!.docs[index].id),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }
}

class SingleMovieDetailsTest extends StatelessWidget {
  const SingleMovieDetailsTest({Key? key, required this.movieId}) : super(key: key);

  final String movieId;

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("films2")
            .doc(movieId)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data!["name"],
                  style: TextStyle(
                    fontSize: screenSize.width * 0.06, // Adjust font size based on screen width
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03), // Adjust spacing based on screen height
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MovieCrewTest(movieId: movieId)),
                    );
                  },
                  child: Text(
                    "Crew",
                    style: TextStyle(fontSize: screenSize.width * 0.04), // Adjust font size based on screen width
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02), // Adjust spacing based on screen height
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MovieCastTest(movieId: movieId)),
                    );
                  },
                  child: Text(
                    "Cast",
                    style: TextStyle(fontSize: screenSize.width * 0.04), // Adjust font size based on screen width
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02), // Adjust spacing based on screen height
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddShows(movieId: movieId)),
                    );
                  },
                  child: Text(
                    "Add Shows",
                    style: TextStyle(fontSize: screenSize.width * 0.04), // Adjust font size based on screen width
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }
}



class MovieCrewTest extends StatefulWidget {
  const MovieCrewTest({Key? key, required this.movieId}) : super(key: key);

  final String movieId;

  @override
  _MovieCrewTestState createState() => _MovieCrewTestState();
}

class _MovieCrewTestState extends State<MovieCrewTest> {
  File? _imageFile; // Change to nullable File type
  String _imageUrl = "";

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<String> uploadImage() async {
    try {
      if (_imageFile != null) {
        // Upload the image to Firebase Storage
        var imageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('crew face')
            .child(DateTime.now().millisecondsSinceEpoch.toString() + '.jpg');
        var uploadTask = imageRef.putFile(_imageFile!);

        // Get the download URL of the uploaded image
        var imageUrl = await (await uploadTask).ref.getDownloadURL();
        setState(() {
          _imageUrl = imageUrl;
        });
        print("------------------------ image uploaded--- $imageUrl");
        return imageUrl;
      } else {
        print('No image selected');
        throw Exception("Error");
      }
    } catch (e) {
      print("$e");
      throw Exception("Error");
    }
  }

  // Function to add crew member
  Future<void> addCrewMember(BuildContext context) async {
    String name = '';
    String role = '';

    final screenSize = MediaQuery.of(context).size;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Crew Member"),
          content: Container(
            width: screenSize.width * 0.8, // Adjust width based on screen width
            height: screenSize.height * 0.3, // Adjust height based on screen height
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: "Name"),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                SizedBox(height: screenSize.height * 0.02), // Adjust spacing based on screen height
                TextField(
                  decoration: InputDecoration(hintText: "Role"),
                  onChanged: (value) {
                    role = value;
                  },
                ),
                SizedBox(height: screenSize.height * 0.02), // Adjust spacing based on screen height
                ElevatedButton(
                  onPressed: pickImageFromGallery,
                  child: Text("Select Image"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            FloatingActionButton(
              onPressed: () async {
                String imageUrl = await uploadImage();
                await FirebaseFirestore.instance
                    .collection("films2")
                    .doc(widget.movieId)
                    .collection("crew")
                    .add({
                  "name": name,
                  "role": role,
                  "crew face": imageUrl,
                });

                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call addCrewMember function when FAB is pressed
          addCrewMember(context);
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("films2")
            .doc(widget.movieId)
            .collection("crew")
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(snapshot.data!.docs[index]["crew face"]),
                  title: Text(snapshot.data!.docs[index]["name"]),
                  subtitle: Text(snapshot.data!.docs[index]["role"]),
                  trailing: Text(snapshot.data!.docs[index].id),
                );
              },
            );
          } else {
            return const Center(
              child: Text("No data"),
            );
          }
        },
      ),
    );
  }
}



class MovieCastTest extends StatefulWidget {
  const MovieCastTest({Key? key, required this.movieId}) : super(key: key);

  final String movieId;

  @override
  _MovieCastTestState createState() => _MovieCastTestState();
}

class _MovieCastTestState extends State<MovieCastTest> {
  File? _imageFile; // Change to nullable File type
  String _imageUrl = "";

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<String> uploadImage() async {
    try {
      if (_imageFile != null) {
        // Upload the image to Firebase Storage
        var imageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('cast face')
            .child(DateTime.now().millisecondsSinceEpoch.toString() + '.jpg');
        var uploadTask = imageRef.putFile(_imageFile!);

        // Get the download URL of the uploaded image
        var imageUrl = await (await uploadTask).ref.getDownloadURL();
        setState(() {
          _imageUrl = imageUrl;
        });
        print("------------------------ image uploaded--- $imageUrl");
        return imageUrl;
      } else {
        print('No image selected');
        throw Exception("Error");
      }
    } catch (e) {
      print("$e");
      throw Exception("Error");
    }
  }

  // Function to add crew member
  Future<void> addCastMember(BuildContext context) async {
    String name = '';
    String role = '';

    final screenSize = MediaQuery.of(context).size;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Cast Member"),
          content: Container(
            width: screenSize.width * 0.8, // Adjust width based on screen width
            height: screenSize.height * 0.3, // Adjust height based on screen height
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: "Name"),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                SizedBox(height: screenSize.height * 0.02), // Adjust spacing based on screen height
                TextField(
                  decoration: InputDecoration(hintText: "Role"),
                  onChanged: (value) {
                    role = value;
                  },
                ),
                SizedBox(height: screenSize.height * 0.02), // Adjust spacing based on screen height
                ElevatedButton(
                  onPressed: pickImageFromGallery,
                  child: Text("Select Image"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            FloatingActionButton(
              onPressed: () async {
                String imageUrl = await uploadImage();
                await FirebaseFirestore.instance
                    .collection("films2")
                    .doc(widget.movieId)
                    .collection("cast")
                    .add({
                  "name": name,
                  "role": role,
                  "cast face": imageUrl,
                });

                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call addCastMember function when FAB is pressed
          addCastMember(context);
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("films2")
            .doc(widget.movieId)
            .collection("cast")
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(snapshot.data!.docs[index]["cast face"]),
                  title: Text(
                    snapshot.data!.docs[index]["name"],
                    style: TextStyle(fontSize: screenSize.width * 0.04), // Adjust font size based on screen width
                  ),
                  subtitle: Text(
                    snapshot.data!.docs[index]["role"],
                    style: TextStyle(fontSize: screenSize.width * 0.035), // Adjust font size based on screen width
                  ),
                  trailing: Text(snapshot.data!.docs[index].id),
                );
              },
            );
          } else {
            return const Center(
              child: Text("No data"),
            );
          }
        },
      ),
    );
  }
}







class AddShows extends StatelessWidget {
  final String movieId;

  const AddShows({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    TextEditingController theatreController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    TextEditingController numberOfTicketsController = TextEditingController();

    void submitData(BuildContext context) {
      String theatre = theatreController.text;
      String date = dateController.text;
      String time = timeController.text;
      int numberOfTickets = int.tryParse(numberOfTicketsController.text) ?? 0;

      if (theatre.isNotEmpty && date.isNotEmpty && time.isNotEmpty && numberOfTickets > 0) {
        FirebaseFirestore.instance
            .collection("films2")
            .doc(movieId)
            .collection("shows")
            .add({
          'theatre': theatre,
          'date': date,
          'time': time,
          'numberOfTickets': numberOfTickets,
        }).then((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowListPage(movieId: movieId),
            ),
          );
        }).catchError((error) {
          print('Error adding data: $error');
        });
      } else {
        print('Please fill in all fields');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Shows'),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.05), // Adjust padding based on screen width
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: theatreController,
                decoration: InputDecoration(labelText: 'Theatre'),
              ),
              SizedBox(height: screenSize.height * 0.02), // Add some vertical spacing based on screen height
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
                keyboardType: TextInputType.datetime, // Set keyboard type to handle date input
              ),
              SizedBox(height: screenSize.height * 0.02), // Add some vertical spacing based on screen height
              TextField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Time'),
              ),
              SizedBox(height: screenSize.height * 0.02), // Add some vertical spacing based on screen height
              TextField(
                controller: numberOfTicketsController,
                decoration: InputDecoration(labelText: 'Number of Tickets'),
                keyboardType: TextInputType.number, // Set keyboard type to handle numeric input
              ),
              SizedBox(height: screenSize.height * 0.02), // Add some vertical spacing based on screen height
              ElevatedButton(
                onPressed: () => submitData(context),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowListPage extends StatelessWidget {
  final String movieId;

  const ShowListPage({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shows'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("films2")
            .doc(movieId)
            .collection("shows")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Widget> showWidgets = snapshot.data!.docs.map((DocumentSnapshot doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return ListTile(
              title: Text('Theatre: ${data['theatre']}'),
              subtitle: Text(
                'Date: ${data['date']}, Time: ${data['time']}, Tickets: ${data['numberOfTickets']}',
                style: TextStyle(fontSize: screenSize.width * 0.04), // Adjust font size based on screen width
              ),
            );
          }).toList();

          return ListView(
            children: showWidgets,
          );
        },
      ),
    );
  }
}



