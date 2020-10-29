import 'package:flutter/material.dart';

class PayInScreen extends StatefulWidget {
  @override
  _PayInScreenState createState() => _PayInScreenState();
}

class _PayInScreenState extends State<PayInScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Center(
              child: Text('Welcome User',
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 15,
                      fontWeight: FontWeight.bold))),
          SizedBox(height: height / 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Product',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height / 70)),
                Text('Amount',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height / 70)),
                Text('Date',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height / 70)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
