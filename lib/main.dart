import 'package:flutter/material.dart';
import 'package:moviesnearby/Admin/1/AddMovies.dart';
import 'package:moviesnearby/Admin/1/Tickets.dart';
import 'package:moviesnearby/Admin/1/UpdateDetails.dart';
import 'package:moviesnearby/Admin/1/Update.dart';
import 'package:moviesnearby/Admin/1/adminhome.dart';
import 'package:moviesnearby/Admin/1/test_data_add.dart';
import 'package:moviesnearby/Admin/login.dart';
import 'package:moviesnearby/User/2/sample.dart';
import 'package:moviesnearby/User/login.dart';
import 'package:moviesnearby/User/1/seeall.dart';
import 'package:moviesnearby/User/signup.dart';
import 'package:moviesnearby/User/1/userhome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moviesnearby/firebase_options.dart';
import 'package:moviesnearby/splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:SplashScreen()
    );
  }
}
