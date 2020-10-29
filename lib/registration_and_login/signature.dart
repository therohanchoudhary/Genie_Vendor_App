import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_app/registration_and_login/email_verification.dart';

class SignatureScreen extends StatefulWidget {
  final String userEmail;

  SignatureScreen({this.userEmail});

  @override
  _SignatureScreen createState() => _SignatureScreen();
}

class _SignatureScreen extends State<SignatureScreen> {
  String _choice1 = 'I want to draw my signature on the screen.';
  String _choice2 = 'I want to upload an image of my signature';
  int _number = 1;
  bool showProgressIndicator = false;
  TextEditingController accountName = TextEditingController();
  File _signatureImage;

  TextEditingController accountNumber = TextEditingController();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _signatureImage = image;
    });
  }

  Future uploadImage() async {
    String fileName = 'seller/signature/${widget.userEmail}';
    StorageReference firebaseStorage =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorage.putFile(_signatureImage);

    await uploadTask.onComplete;
  }

  _widget(String text, int num) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: num == _number ? Colors.blue : Colors.white,
                border: Border.all(color: Colors.blue)),
          ),
          SizedBox(width: 20),
          Flexible(
              child: Text(
            text,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text('Signature',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
                SizedBox(height: 40),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _number = 1;
                      });
                    },
                    child: _widget(_choice1, 1)),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _number = 2;
                      });
                    },
                    child: _widget(_choice2, 2)),
                SizedBox(height: 40),
                _number == 1
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(40)),
                          child: Center(
                              child: Text('Sign Here',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue))),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(40)),
                            child: _signatureImage == null
                                ? Center(
                                    child: Text('Click here to Upload',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue)))
                                : Container(
                                    padding: EdgeInsets.all(20),
                                    height: 150,
                                    width: 300,
                                    child: Image.file(_signatureImage)),
                          ),
                        ),
                      ),
                SizedBox(height: 70),
                GestureDetector(
                  onTap: () async {
                    if (_signatureImage != null) {
                      uploadImage();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EmailVerification()));
                    }
                  },
                  child: showProgressIndicator == false
                      ? Container(
                          height: 50,
                          width: 300,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
