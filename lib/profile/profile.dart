import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/bottom_navigation_bar.dart';
import 'package:vendor_app/profile/edit_profile_picture.dart';
import 'package:vendor_app/profile/edit_profile_string_values.dart';
import 'package:vendor_app/profile/edit_signature.dart';
import 'package:vendor_app/registration_and_login/login.dart';
import 'package:vendor_app/registration_and_login/register_bank_details.dart';
import 'package:vendor_app/registration_and_login/register_business_details.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName;
  var profilePicURL = "ii";
  bool noProfilePic = false;
  bool showSpinner = false;

  Future getUserName(String email) async {
    setState(() async {
      await FirebaseFirestore.instance
          .collection('registerSeller')
          .doc(email)
          .get()
          .then((value) =>
              userName = value.data()["ownerName"].toString().toUpperCase());
      setState(() {});
      print(userName);
    });
  }

  Future _getImage() async {
    setState(() {
      showSpinner = true;
    });
    try {
      profilePicURL = await FirebaseStorage.instance
          .ref()
          .child('seller/profilePic/${FirebaseAuth.instance.currentUser.email}')
          .getDownloadURL();
    } catch (e) {
      setState(() {
        noProfilePic = true;
      });
      print(noProfilePic);
      print(e);
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void initState() {
    super.initState();
    User user = FirebaseAuth.instance.currentUser;
    getUserName(user.email);
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    _widget(String text, var whereToGo) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 15),
        child: GestureDetector(
          onTap: () {
            print(whereToGo);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => whereToGo));
          },
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  print(whereToGo);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => whereToGo));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: height / 70)),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: height / 60,
                    )
                  ],
                ),
              ),
              SizedBox(height: height / 50),
              Container(
                  height: 0.3, width: double.infinity, color: Colors.blue[300]),
              SizedBox(height: height / 50),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipPath(
                    clipper: BottomWaveClipper(),
                    child: Container(
                      height: height / 3.7,
                      width: width,
                      color: Colors.blue[300],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showSpinner == false
                          ? Container(
                              width: height / 6,
                              height: height / 6,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(noProfilePic == false
                                          ? profilePicURL
                                          : "https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg"))))
                          : CircularProgressIndicator(),
                      SizedBox(width: width / 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userName != null && userName.toLowerCase() != "null"
                              ? Text(userName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width / 28,
                                      fontWeight: FontWeight.bold))
                              : Text("Loading name...",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width / 25,
                                      fontWeight: FontWeight.bold)),
                          SizedBox(height: height / 150),
                          Text(user.email,
                              style: TextStyle(
                                  color: Colors.white, fontSize: width / 55)),
                          SizedBox(height: height / 60),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(1000)),
                            height: height / 22,
                            width: width / 2.5,
                            child: Center(
                                child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  color: Colors.blue[300],
                                  fontSize: width / 35,
                                  fontWeight: FontWeight.bold),
                            )),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: height / 70),
              _widget(
                  'Shop Name',
                  EditProfileStrings(
                      attribute: 'shopName',
                      hintText: 'Edit your shop name',
                      keyboardType: TextInputType.name)),
              _widget(
                  'Owner Name',
                  EditProfileStrings(
                      attribute: 'ownerName',
                      hintText: 'Edit your name',
                      keyboardType: TextInputType.name)),
              _widget(
                  'Mobile Number',
                  EditProfileStrings(
                      attribute: 'mobileNumber',
                      hintText: "Enter new Mobile Number",
                      keyboardType: TextInputType.number)),
              _widget('List of Products', BottomNavigationBarScreen()),
              _widget(
                  'Bank Details',
                  BankDetails(
                      userEmail: FirebaseAuth.instance.currentUser.email,
                      fromProfile: true)),
              _widget(
                  'Business Details',
                  BusinessDetails(
                      fromProfile: true,
                      userEmail: FirebaseAuth.instance.currentUser.email)),
              _widget('Signature', EditSignature()),
              _widget(
                  'Address',
                  EditProfileStrings(
                      attribute: 'address',
                      hintText: "Enter new address",
                      keyboardType: TextInputType.streetAddress)),
              _widget('Profile Picture', EditProfilePicture()),
              GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()));
                  },
                  child: Text(
                    'Signout',
                    style:
                        TextStyle(color: Colors.black, fontSize: height / 70),
                  )),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 20, size.height - 100);
    var firstEndPoint = Offset(size.width / 1.3, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width, size.height);
    var secondEndPoint = Offset(size.width, size.height - 40);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
