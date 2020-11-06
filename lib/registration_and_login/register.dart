import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/registration_and_login/login.dart';
import 'package:vendor_app/registration_and_login/register_business_details.dart';
import 'package:vendor_app/useful_methods.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _showProgressIndicator = false;

  _input(String hintText, double height, int maxLines, var keyboardType,
      var controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        height: height,
        child: TextField(
          obscureText: hintText == 'Password',
          maxLines: hintText == 'Address' ? 4 : maxLines,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(40),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300], width: 5.0),
                borderRadius: BorderRadius.circular(40),
              ),
              filled: true,
              isDense: true,
              contentPadding: EdgeInsets.all(20),
              hintStyle: TextStyle(color: Colors.grey[800], fontSize: 12),
              hintText: hintText,
              fillColor: Colors.grey[300]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameEntered = TextEditingController();
    TextEditingController emailEntered = TextEditingController();
    TextEditingController mobileNumberEntered = TextEditingController();
    TextEditingController passwordEntered = TextEditingController();
    TextEditingController otpEntered = TextEditingController();
    TextEditingController addressEntered = TextEditingController();

    final databaseReference = FirebaseFirestore.instance;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                Text('Register',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: 40),
                _input('User Name', 80, 1, TextInputType.name, usernameEntered),
                _input('Email Id', 80, 1, TextInputType.emailAddress,
                    emailEntered),
                _input('Mobile Number', 80, 1, TextInputType.number,
                    mobileNumberEntered),
                _input('Password', 80, 1, TextInputType.visiblePassword,
                    passwordEntered),
                _input(
                    'Address', 80, 4, TextInputType.multiline, addressEntered),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    try {
                      setState(() {
                        _showProgressIndicator = true;
                      });

                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailEntered.text,
                              password: passwordEntered.text);

                      await databaseReference
                          .collection('registerSeller')
                          .doc(emailEntered.text.toString())
                          .set({
                        "name": usernameEntered.text,
                        "email": emailEntered.text,
                        "address": addressEntered.text,
                        "password": passwordEntered.text,
                        "mobileNumber": mobileNumberEntered.text,
                        "verified": false,
                        "productsUploaded": 0
                      });

                      setState(() {
                        _showProgressIndicator = false;
                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BusinessDetails(
                                      userEmail: emailEntered.text,
                                      fromProfile: false)));
                    } catch (e) {
                      print(e);
                      UsefulMethods()
                          .showToast("Please enter correct credentials");
                      emailEntered.text = "";
                      passwordEntered.text = "";
                      mobileNumberEntered.text = "";
                      otpEntered.text = "";
                      addressEntered.text = "";
                      usernameEntered.text = "";

                      setState(() {
                        _showProgressIndicator = false;
                      });
                    }
                  },
                  child: _showProgressIndicator == false
                      ? Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Text(
                              'Continue',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        )
                      : CircularProgressIndicator(),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen())),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
