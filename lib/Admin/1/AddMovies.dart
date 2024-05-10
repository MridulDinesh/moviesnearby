import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart'; // Import image_picker package
import 'package:moviesnearby/Admin/1/test_data_add.dart';

class Addmoviedetails extends StatefulWidget {
  const Addmoviedetails({Key? key}) : super(key: key);

  @override
  State<Addmoviedetails> createState() => _AddmoviedetailsState();
}

class _AddmoviedetailsState extends State<Addmoviedetails> {
  TextEditingController _durationController = TextEditingController();
  TextEditingController _langController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _storyController = TextEditingController();
  File? _imageFile; // Change to nullable File type
  String _imageUrl="";

  @override
  void dispose() {
    _durationController.dispose();
    _langController.dispose();
    _nameController.dispose();
    _storyController.dispose();
    super.dispose();
  }

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
            .child('posters')
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
        throw Exception("Error: No image selected");
      }
    } catch (e) {
      print("Error uploading image: $e");
      throw Exception("Error uploading image: $e");
    }
  }

  addDatatest(name, duration, lang, story) async {
    var dbInstance = FirebaseFirestore.instance;
    try {
      // Add data to Firestore
      var img = await uploadImage();
      var ref = await dbInstance.collection("films2").add({
        "name": name,
        "lang": lang,
        "duration": duration,
        "story": story,
        "poster": img, // Store the download URL of the image
      });

      // Extract the ID of the newly added document
      String movieId = ref.id;

      // Navigate to SingleMovieDetailsTest page after successfully adding data
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SingleMovieDetailsTest(movieId: movieId)),
      );
    } catch (e) {
      print("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Movie details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03), // 3% of screen height
            _imageFile != null
                ? Image.file(
              _imageFile!,
              height: screenHeight * 0.3, // 30% of screen height
              width: screenWidth * 0.8, // 80% of screen width
              fit: BoxFit.cover,
            )
                : Placeholder(
              fallbackHeight: screenHeight * 0.3,
              fallbackWidth: screenWidth * 0.8,
            ),
            SizedBox(height: screenHeight * 0.03), // 3% of screen height
            ElevatedButton(
              onPressed: () async {
                await pickImageFromGallery(); // Pick image from gallery
              },
              child: Text('Pick Image'),
            ),
            SizedBox(height: screenHeight * 0.03), // 3% of screen height
            TextField(
              controller: _durationController,
              decoration: InputDecoration(labelText: 'Duration'),
            ),
            TextField(
              controller: _langController,
              decoration: InputDecoration(labelText: 'Language'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _storyController,
              decoration: InputDecoration(labelText: 'Story'),
              maxLines: 8,
            ),
            SizedBox(height: screenHeight * 0.03), // 3% of screen height
            ElevatedButton(
              onPressed: () {
                if (_imageUrl != null) {
                  addDatatest(
                    _nameController.text,
                    _durationController.text,
                    _langController.text,
                    _storyController.text,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please pick an image'),
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

}
