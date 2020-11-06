import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/menu/tab_bar_menu.dart';
import 'package:vendor_app/menu/add_product.dart';

class CategoryScreen extends StatefulWidget {
  final String email;

  CategoryScreen({this.email});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class CategoriesContent {
  final String category;
  final String image;

  CategoriesContent({this.category, this.image});
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoriesContent> categoryList = [];

  Future _getData(String email) async {
    var _db =
        await FirebaseFirestore.instance.collection("shop").doc('2').get();
    for (int i = 0; i < _db.data()["products"].length; i++) {
      var x = _db.data()["products"][i];

      if (x == null) {
        print(categoryList);
        return;
      } else {
        categoryList.add(
            CategoriesContent(image: x["img"][0], category: x["category"]));
      }
      if (mounted) {
        setState(() {});
      }
    }
    categoryList = categoryList.toSet().toList();
  }

  @override
  void initState() {
    User user = FirebaseAuth.instance.currentUser;
    _getData(user.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    print(categoryList);
    _gridCardWidget(int index) {
      return GestureDetector(
        onTap: () {
          print(categoryList[index].category);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      TabBarMenu(category: categoryList[index].category)));
        },
        child: Container(
            height: height / 4.7,
            width: width / 2.3,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(
                      width: width / 2.3,
                      height: height / 7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(categoryList[index].image)))),
                ),
                SizedBox(height: height / 150),
                Text(categoryList[index].category,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.black, fontSize: height / 70)),
              ],
            )),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
                child: Text('Welcome User',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                        fontWeight: FontWeight.bold))),
            categoryList.length != 0
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categoryList.length ~/ 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _gridCardWidget(index * 2),
                              SizedBox(width: width / 30),
                              _gridCardWidget(index * 2 + 1),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    },
                  )
                : Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
            categoryList.length % 2 == 1
                ? _gridCardWidget(categoryList.length - 1)
                : Container(),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          print(widget.email),
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AddProduct(emailSeller: widget.email)))
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
