import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_app/menu/add_product.dart';

class ProductAddImage extends StatefulWidget {
  final String documentName;
  final String email;

  ProductAddImage({this.documentName, this.email});

  @override
  _ProductAddImageState createState() => _ProductAddImageState();
}

class _ProductAddImageState extends State<ProductAddImage> {
  File image1, image2, image3, image4;
  String urlImage1, urlImage2, urlImage3, urlImage4;
  bool showSpinner = false;

  Future uploadImage(int n, File imageFile) async {
    StorageReference ref = FirebaseStorage().ref().child(
        "seller/product/${widget.email}/${widget.documentName}/image_$n");
    StorageUploadTask uploadTask = ref.putFile(imageFile);

    var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    if (n == 1) urlImage1 = downloadUrl.toString();
    if (n == 2) urlImage2 = downloadUrl.toString();
    if (n == 3) urlImage3 = downloadUrl.toString();
    if (n == 4) urlImage4 = downloadUrl.toString();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height / 40),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'You need to add 4 images for your product. Click the + sign to add.',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image1 == null
                      ? GestureDetector(
                          child: Container(
                              height: height / 3,
                              width: width / 2.5,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.circular(height / 30)),
                              child: Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: height / 20,
                              )),
                          onTap: () async {
                            var image = await ImagePicker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              image1 = image;
                            });
                            uploadImage(1, image1);
                          },
                        )
                      : Container(
                          height: height / 3,
                          width: width / 2.5,
                          child: Image.file(image1)),
                  SizedBox(width: width / 10),
                  image2 == null
                      ? GestureDetector(
                          child: Container(
                              height: height / 3,
                              width: width / 2.5,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.circular(height / 30)),
                              child: Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: height / 20,
                              )),
                          onTap: () async {
                            var image = await ImagePicker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              image2 = image;
                            });
                            uploadImage(2, image2);
                          },
                        )
                      : Container(
                          height: height / 3,
                          width: width / 2.5,
                          child: Image.file(image2)),
                ],
              ),
              SizedBox(height: height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image3 == null
                      ? GestureDetector(
                          child: Container(
                              height: height / 3,
                              width: width / 2.5,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.circular(height / 30)),
                              child: Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: height / 20,
                              )),
                          onTap: () async {
                            var image = await ImagePicker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              image3 = image;
                            });
                            uploadImage(3, image3);
                          },
                        )
                      : Container(
                          height: height / 3,
                          width: width / 2.5,
                          child: Image.file(image3)),
                  SizedBox(width: width / 10),
                  image4 == null
                      ? GestureDetector(
                          child: Container(
                              height: height / 3,
                              width: width / 2.5,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.circular(height / 30)),
                              child: Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: height / 20,
                              )),
                          onTap: () async {
                            var image = await ImagePicker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              image4 = image;
                            });
                            uploadImage(4, image4);
                          },
                        )
                      : Container(
                          height: height / 3,
                          width: width / 2.5,
                          child: Image.file(image4)),
                ],
              ),
              SizedBox(height: height / 50),
              showSpinner == false
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          showSpinner = true;
                        });
                        if (image1 != null &&
                            image2 != null &&
                            image3 != null &&
                            image4 != null &&
                            urlImage1 != null &&
                            urlImage2 != null &&
                            urlImage3 != null &&
                            urlImage4 != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => AddProduct(
                                        url1: urlImage1,
                                        url2: urlImage2,
                                        url3: urlImage3,
                                        url4: urlImage4,
                                        emailSeller: widget.email,
                                      )));
                          Fluttertoast.showToast(
                              msg: "Images added succesfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 12.0);
                        } else {
                          if (image1 != null &&
                              image2 != null &&
                              image3 != null &&
                              image4 != null)
                            Fluttertoast.showToast(
                                msg: "Uploading photos...",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          else
                            Fluttertoast.showToast(
                                msg: "Please add all 4 photos.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 12.0);
                        }
                        setState(() {
                          showSpinner=false;
                        });
                      },
                      child: Container(
                          height: height / 15,
                          width: width / 1.8,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(height)),
                          child: Center(
                              child: Text('Done',
                                  style: TextStyle(color: Colors.white)))),
                    )
                  : CircularProgressIndicator(),
              SizedBox(height: height / 50),
            ],
          ),
        ),
      ),
    );
  }
}
