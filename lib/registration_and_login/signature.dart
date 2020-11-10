import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_app/registration_and_login/login.dart';

class SignatureScreen extends StatefulWidget {
  final String userEmail;

  SignatureScreen({this.userEmail});

  @override
  _SignatureScreen createState() => _SignatureScreen();
}

class _SignatureScreen extends State<SignatureScreen> {
  bool showProgressIndicator = false;
  TextEditingController accountName = TextEditingController();
  File _signatureImage;

  TextEditingController accountNumber = TextEditingController();

  Future _getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _signatureImage = File(image.path);
    });
  }

  Future _uploadImage() async {
    String fileName = 'seller/signature/${widget.userEmail}';
    StorageReference firebaseStorage =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorage.putFile(_signatureImage);

    await uploadTask.onComplete;
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
                SizedBox(height: 25),
                Image.asset('assets/images/logo1.png'),
                Center(
                    child: Text('Signature',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      _getImage();
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
                      _uploadImage();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LoginScreen()));
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
