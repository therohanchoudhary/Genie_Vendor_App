import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/registration_and_login/not_registered_user_screen.dart';
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
  bool showSpinner = false;

  Future getVerified(String email) async {
    setState(() {
      showSpinner = true;
    });
    verified = await FirebaseFirestore.instance
        .collection("registerSeller")
        .doc(email)
        .get()
        .then((value) => verified = value.data()["verified"]);
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void initState() {
    super.initState();
    User user = FirebaseAuth.instance.currentUser;
    if (user != null) getVerified(user.email);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    User user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: showSpinner == true
          ? Container(color: Colors.white)
          : user == null
              ? LoginScreen()
              : verified == true
                  ? BottomNavigationBarScreen()
                  : WaitingScreen(),
    );
  }
}
