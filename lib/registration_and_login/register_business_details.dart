import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/bottom_navigation_bar.dart';
import 'package:vendor_app/registration_and_login/register_bank_details.dart';
import 'package:vendor_app/useful_methods.dart';

class BusinessDetails extends StatefulWidget {
  final String userEmail;
  final bool fromProfile;

  BusinessDetails({this.userEmail, this.fromProfile});

  @override
  _BusinessDetailsState createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  String _choice1 = 'I have a GSTIN';
  String _choice2 = 'I only sell in GSTIN exempt categories like books';
  String _choice3 = 'I have applied/will apply for GSTIN';
  int _number = 1;
  TextEditingController ggstinNumber = TextEditingController();
  bool _showProgressIndicator = false;

  _widget(String text, int num) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: GestureDetector(
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
                child: Text(text,
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String _choice = _choice1;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  'Give your Business Details',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
                SizedBox(height: 40),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _number = 1;
                        _choice = _choice1;
                      });
                    },
                    child: _widget(_choice1, 1)),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _number = 2;
                        _choice = _choice2;
                      });
                    },
                    child: _widget(_choice2, 2)),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _number = 3;
                        _choice = _choice3;
                      });
                    },
                    child: _widget(_choice3, 3)),
                SizedBox(height: 70),
                Stack(
                  alignment: Alignment(0.78, 0.00),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        maxLines: 1,
                        controller: ggstinNumber,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[300], width: 2.0),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.all(20),
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 12),
                            hintText: 'GGSTIN Number',
                            fillColor: Colors.grey[300]),
                      ),
                    ),
                    Text('Verify', style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    _showProgressIndicator = true;

                    if (ggstinNumber.text != null && ggstinNumber.text != "") {
                      await FirebaseFirestore.instance
                          .collection('registerSeller')
                          .doc(widget.userEmail)
                          .update({
                        'businessDetail': _choice,
                        'ggstinNumber': ggstinNumber.text,
                      });
                      if (widget.fromProfile == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BottomNavigationBarScreen()));
                        UsefulMethods().showToast(
                            "Business details are changed successfully.");
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => BankDetails(
                                    userEmail: widget.userEmail,
                                    fromProfile: false)));
                      }
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BottomNavigationBarScreen()));
                      UsefulMethods().showToast("Incorrect credentials.");
                    }
                    _showProgressIndicator = false;
                  },
                  child: _showProgressIndicator == false
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
