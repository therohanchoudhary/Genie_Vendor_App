import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/registration_and_login/login.dart';
import 'package:vendor_app/useful_methods.dart';

class EmailVerification extends StatefulWidget {
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    bool showSpinner = false;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              Image.asset('assets/images/logo1.png'),
              SizedBox(height: 25),
              Center(
                  child: Text('Email Verification',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                          fontWeight: FontWeight.bold))),
              SizedBox(height: 50),
              Center(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                      'Hfnijene grugbriwb gbtb grtigtriwgw gwrbgirwbg. '
                      'Hfnijene grugbriwb gbtb grtigtriwgw gwrbgirwbg. '
                      'Hfnijene grugbriwb gbtb grtigtriwgw gwrbgirwbg. '
                      'Hfnijene grugbriwb gbtb grtigtriwgw gwrbgirwbg. '
                      'Hfnijene grugbriwb gbtb grtigtriwgw gwrbgirwbg. '
                      'Hfnijene grugbriwb gbtb grtigtriwgw gwrbgirwbg. '
                      'Hfnijene grugbriwb gbtb grtigtriwgw gwrbgirwbg. ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[400], fontSize: 10, height: 2)),
              )),
              SizedBox(height: 110),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    UsefulMethods().showToast(
                        "An email has been sent to your email id. Click on the verification link to verify your email");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()));
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      showSpinner = false;
                    });
                    UsefulMethods().showToast("Error -> $e");
                  }
                  setState(() {
                    showSpinner = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                },
                child: showSpinner == false
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        height: 50,
                        width: 300,
                        child: Center(
                            child: Text('Continue',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10))),
                      )
                    : CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
