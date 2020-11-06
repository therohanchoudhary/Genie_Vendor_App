import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/not_registered_user_screen.dart';
import 'package:vendor_app/registration_and_login/login.dart';
import 'bottom_navigation_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool verified = false;

  Future getVerified(String email) async {
    verified = await FirebaseFirestore.instance
        .collection("registerSeller")
        .doc(email)
        .get()
        .then((value) => verified = value.data()["verified"]);
  }

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser.email != null)
      getVerified(FirebaseAuth.instance.currentUser.email);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirebaseAuth.instance.currentUser.email == null
          ? LoginScreen()
          : verified == true
              ? BottomNavigationBarScreen()
              : WaitingScreen(),
    );
  }
}
