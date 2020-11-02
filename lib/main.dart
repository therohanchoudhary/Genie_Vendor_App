import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/not_registered_user_screen.dart';
import 'package:vendor_app/registration_and_login/register.dart';
import 'bottom_navigation_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //bool verified = false;

  // Future getVerification(String email) async {
  //   await FirebaseFirestore.instance
  //       .collection("registerSeller")
  //       .doc(email)
  //       .get()
  //       .then((value) {
  //     verified = value.data()["verified"];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    //getVerification(user.email);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirebaseAuth.instance.currentUser != null
          //? {verified == true ? BottomNavigationBarScreen() : WaitingScreen()}
          ? BottomNavigationBarScreen()
          : RegistrationScreen(),
    );
  }
}
