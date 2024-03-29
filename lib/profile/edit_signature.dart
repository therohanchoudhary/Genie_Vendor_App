import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_app/useful_methods.dart';

class EditSignature extends StatefulWidget {
  @override
  _EditSignatureState createState() => _EditSignatureState();
}

class _EditSignatureState extends State<EditSignature> {
  String signatureUrl;
  bool showSpinner = false;
  File _newSigntaure;

  Future _getImage() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('seller/signature/${FirebaseAuth.instance.currentUser.email}');
    signatureUrl = await ref.getDownloadURL();
    setState(() {});
    print(signatureUrl);
  }

  Future _getImageFile() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _newSigntaure = File(image.path);
    });
  }

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Signature')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('Current Signature'),
                      SizedBox(height: 20),
                      signatureUrl == null
                          ? CircularProgressIndicator()
                          : Container(
                              height: 200,
                              width: 200,
                              child: Image.network(signatureUrl)),
                    ],
                  ),
                  _newSigntaure != null
                      ? Column(
                          children: [
                            Text('New Signature'),
                            SizedBox(height: 20),
                            signatureUrl == null
                                ? CircularProgressIndicator()
                                : Container(
                                    height: 200,
                                    width: 200,
                                    child: Image.file(_newSigntaure)),
                          ],
                        )
                      : SizedBox(width: 0),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _getImageFile,
                child: Text('Choose new signature',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline)),
              ),
              SizedBox(height: 20),
              showSpinner == false
                  ? GestureDetector(
                      onTap: () async {
                        if (_newSigntaure != null) {
                          setState(() {
                            showSpinner = true;
                          });
                          StorageReference firebaseStorage =
                              FirebaseStorage.instance.ref().child(
                                  'seller/signature/${FirebaseAuth.instance.currentUser.email}');
                          StorageUploadTask uploadTask =
                              firebaseStorage.putFile(_newSigntaure);

                          await uploadTask.onComplete;
                          setState(() {
                            showSpinner = false;
                          });
                          UsefulMethods()
                              .showToast("Signature changed successfully.");
                        } else {
                          UsefulMethods()
                              .showToast("Signature file not changed");
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 60,
                        width: 300,
                        padding: EdgeInsets.all(20),
                        child: Center(
                            child: Text('Upload my signature now',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12))),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(1000)),
                      ),
                    )
                  : CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
