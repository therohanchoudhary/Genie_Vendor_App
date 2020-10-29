import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/registration_and_login/signature.dart';

class BankDetails extends StatefulWidget {
  final String userEmail;

  BankDetails({this.userEmail});

  @override
  _BankDetails createState() => _BankDetails();
}

class _BankDetails extends State<BankDetails> {
  String _choice1 = 'I have a bank account in my registered business name.';
  String _choice2 =
      'I have applied/will apply for a bank account in my registered business name';
  int _number = 1;
  bool showProgressIndicator = false;
  TextEditingController accountName = TextEditingController();

  TextEditingController accountNumber = TextEditingController();

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
                  'Give your Bank Details',
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
                SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    maxLines: 1,
                    controller: accountName,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
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
                        hintText: "Account holder's name",
                        fillColor: Colors.grey[300]),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    maxLines: 1,
                    controller: accountNumber,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
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
                        hintText: 'Bank Account Number',
                        fillColor: Colors.grey[300]),
                  ),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      showProgressIndicator = true;
                    });
                    await FirebaseFirestore.instance
                        .collection('seller')
                        .doc(widget.userEmail)
                        .update({
                      'bankDetail': _choice,
                      'bankAccountName': accountName.text,
                      'bankAccountNumber': accountNumber.text,
                    });
                    setState(() {
                      showProgressIndicator = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SignatureScreen(userEmail: widget.userEmail)));
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
