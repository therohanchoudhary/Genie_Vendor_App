import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_app/menu/categories.dart';
import 'package:vendor_app/registration_and_login/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEntered = TextEditingController();
  TextEditingController passwordEntered = TextEditingController();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Text('LOGIN',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  maxLines: 1,
                  controller: emailEntered,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 2.0),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.all(20),
                      hintStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 12),
                      hintText: 'Email ID',
                      fillColor: Colors.grey[300]),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  maxLines: 1,
                  controller: passwordEntered,
                  obscureText: true,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 2.0),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.all(20),
                      hintStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 12),
                      hintText: 'Password',
                      fillColor: Colors.grey[300]),
                ),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailEntered.text,
                        password: passwordEntered.text);

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('boolValue', true);

                    setState(() {
                      showSpinner = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => CategoryScreen()));
                  } on FirebaseAuthException catch (e) {
                    print(e);
                    setState(() {
                      showSpinner = false;
                    });
                    Fluttertoast.showToast(
                        msg: "Please enter correct credentials",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                },
                child: showSpinner == false
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        height: 50,
                        width: 300,
                        child: Center(
                            child: Text('Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10))),
                      )
                    : CircularProgressIndicator(),
              ),
              SizedBox(height: 100),
              Center(
                  child: Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 10, color: Colors.grey[500]),
              )),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RegistrationScreen()));
                },
                child: Center(
                    child: Text(
                  "Create account",
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue[300],
                      decoration: TextDecoration.underline),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
