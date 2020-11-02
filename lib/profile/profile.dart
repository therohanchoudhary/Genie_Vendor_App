import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/registration_and_login/login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    _widget(String text) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height / 70)),
                Icon(
                  Icons.arrow_forward_ios,
                  size: height / 60,
                )
              ],
            ),
            SizedBox(height: height / 50),
            Container(
                height: 0.3, width: double.infinity, color: Colors.blue[300]),
            SizedBox(height: height / 50),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height / 4,
                width: width,
                color: Colors.blue[300],
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: height / 6,
                          height: height / 6,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQruje6GylG0zg0LEmTpcI4l4Xrrd6CRgbw3w&usqp=CAU")))),
                      SizedBox(width: width / 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('John Doe',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width / 14,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: height / 150),
                          Text('email@gmail.com',
                              style: TextStyle(
                                  color: Colors.white, fontSize: width / 35)),
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
                ),
              ),
              SizedBox(height: height / 30),
              _widget('Shop Name'),
              _widget('Owner Name'),
              _widget('Mobile Number'),
              _widget('Email ID'),
              _widget('List of Products'),
              _widget('Bank Details'),
              _widget('Business Details'),
              _widget('Signature'),
              _widget('Address'),
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

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
