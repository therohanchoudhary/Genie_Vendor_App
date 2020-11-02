import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/order/TabBarOrder.dart';
import 'package:vendor_app/menu/categories.dart';
import 'package:vendor_app/pay_in/pay_in.dart';
import 'package:vendor_app/profile/profile.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {


  @override
  Widget build(BuildContext context) {

    User user = FirebaseAuth.instance.currentUser;

    int _currentIndex = 0;

    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    final List<Widget> _children = [
      CategoryScreen(email: user.email),
      TabBarOrder(),
      PayInScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Order'),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_filled), label: 'Pay-in'),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_filled), label: 'Profile'),
        ],
      ),
    );
  }
}
