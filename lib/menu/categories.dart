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
  final int categoryNumber;

  CategoriesContent({this.category, this.image, this.categoryNumber});
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoriesContent> categoryList = [];
  bool noProducts = false;

  var sellerId;

  Future _getSellerId(String email) async {
    await FirebaseFirestore.instance
        .collection('registerSeller')
        .doc(email)
        .get()
        .then((value) => sellerId = value.data()["id"].toString());
  }

  Future _getData(String email) async {
    for (int ii = 0; ii <= 12; ii++) {
      var _db =
          await FirebaseFirestore.instance.collection("shop").doc('$ii').get();

      for (int i = 0; i < _db.data()["products"].length; i++) {
        var x = _db.data()["products"][i];
        if (x == null) {
          print("$ii    $i");
          return;
        } else {
          if (x["sellerid"] == sellerId) {
            categoryList.add(CategoriesContent(
                image: "assets/images/${ii == 12 ? ii : ii + 1}.png",
                category: x["category"],
                categoryNumber: ii));
            var categoryNumbers =
                categoryList.map((e) => e.categoryNumber).toSet();
            categoryList
                .retainWhere((x) => categoryNumbers.remove(x.categoryNumber));
          }
        }
        if (mounted) {
          setState(() {});
        }
      }
    }

    if (categoryList.length == 0)
      setState(() {
        noProducts = true;
      });
  }

  @override
  void initState() {
    User user = FirebaseAuth.instance.currentUser;
    _getSellerId(user.email);
    _getData(user.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    _gridCardWidget(int index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => TabBarMenu(
                      category: categoryList[index].category,
                      categoryNumber: categoryList[index].categoryNumber)));
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(categoryList[index].image)))),
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
                child: Text('Welcome Vendor',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                        fontWeight: FontWeight.bold))),
            noProducts == true
                ? Column(
                    children: [
                      SizedBox(height: 50),
                      Text('No products added by you'),
                    ],
                  )
                : categoryList.length != 0
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
                    : Column(
                        children: [
                          SizedBox(height: 20),
                          CircularProgressIndicator()
                        ],
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
