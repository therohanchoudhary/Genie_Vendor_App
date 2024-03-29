import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/registration_and_login/login.dart';

class WaitingScreen extends StatefulWidget {
  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              Image.asset('assets/images/logo1.png'),
              SizedBox(height: 25),
              Text(
                  'Please wait ${user.email}.\n'
                  'Your registration details are under our review.\n',
                  textAlign: TextAlign.center),
              user.emailVerified == false
                  ? Column(
                      children: [
                        Text(
                            'Please verify your email otherwise your application would be rejected.',
                            textAlign: TextAlign.center),
                        GestureDetector(
                          onTap: () {
                            user.sendEmailVerification();
                          },
                          child: Text(
                            'Send verification email.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontSize: 10),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(height: 0),
              SizedBox(height: 100),
              GestureDetector(
                child: Text('Signout',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 10)),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
