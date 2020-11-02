import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddImage extends StatefulWidget {
  final String documentName;

  ProductAddImage({this.documentName});

  @override
  _ProductAddImageState createState() => _ProductAddImageState();
}

class _ProductAddImageState extends State<ProductAddImage> {
  File image1, image2, image3, image4;

  Future getImage(File imageFile) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = image;
    });
  }

  Future uploadImage(int n, File imageFile) async {
    // String fileName = 'seller/product/${widget.documentName}/image_$n';
    // StorageReference firebaseStorage =
    //     FirebaseStorage.instance.ref().child(fileName);
    // StorageUploadTask uploadTask = firebaseStorage.putFile(imageFile);
    //
    // await uploadTask.onComplete;

    await FirebaseStorage.instance
        .ref()
        .child('seller/product/${widget.documentName}/image_$n')
        .putFile(imageFile)
        .onComplete;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
                'You need to add 4 images for your product. Click the + sign to add'),
            GestureDetector(
              child: Container(
                height: 200,
                width: double.infinity,
                child: Text('Pic1'),
              ),
              onTap: () {
                getImage(image1);
                uploadImage(1, image1);
              },
            ),
            GestureDetector(
              child: Container(
                height: 200,
                width: double.infinity,
                child: Text('Pic2'),
              ),
              onTap: () {
                getImage(image2);
                uploadImage(2, image2);
              },
            ),
            GestureDetector(
              child: Container(
                height: 200,
                width: double.infinity,
                child: Text('Pic3'),
              ),
              onTap: () {
                getImage(image3);
                uploadImage(3, image3);
              },
            ),
            GestureDetector(
              child: Container(
                height: 200,
                width: double.infinity,
                child: Text('Pic4'),
              ),
              onTap: () {
                getImage(image4);
                uploadImage(1, image4);
              },
            ),
          ],
        ),
      ),
    );
  }
}
