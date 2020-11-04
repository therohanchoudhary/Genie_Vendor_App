import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  final bool outOfStock;
  final String category;

  ProductListScreen({this.outOfStock, this.category});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class ProductList {
  final String offer;
  final String name;
  final String rate;
  final String type;
  final String image;
  bool outOfStock;
  final int firebaseIndex;

  ProductList(
      {this.offer,
      this.name,
      this.type,
      this.firebaseIndex,
      this.rate,
      this.outOfStock,
      this.image});
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductList> productList = [];

  Future _getData(String email) async {
    var _db =
        await FirebaseFirestore.instance.collection("shop").doc('2').get();
    var id;
    await FirebaseFirestore.instance
        .collection("registerSeller")
        .doc(email)
        .get()
        .then((value) => id = value.data()["id"]);
    print(id);

    for (int i = 0; i < _db.data()["products"].length; i++) {
      if (_db.data()["products"][i] == null) break;
      if (_db.data()["products"][i]["id"].toString() == id.toString() &&
          _db.data()["products"][i]["category"].toString() == widget.category) {
        productList.add(
          ProductList(
              offer: _db.data()["products"][i]["discount"].toString() + "% OFF",
              name: _db.data()["products"][i]["name"].toString(),
              firebaseIndex: i,
              type: _db
                  .data()["products"][i]["category"]
                  .toString()
                  .toUpperCase(),
              rate: _db.data()["products"][i]["mprice"].toString(),
              outOfStock: _db.data()["products"][i]["outOfStock"] == true,
              image: _db.data()["products"][i]["img"][0]),
        );
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    User user = FirebaseAuth.instance.currentUser;
    _getData(user.email);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    setState(() {});
    print("Product list is $productList");
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            productList.length != 0
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: productList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        if (widget.outOfStock == productList[index].outOfStock)
                          return Padding(
                            padding: EdgeInsets.all(height / 50),
                            child: Container(
                              height: height / 7,
                              width: width / 1.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: width / 20),
                                  Container(
                                    height: height / 7,
                                    width: width / 5,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Image.network(
                                        '${productList[index].image}'),
                                  ),
                                  SizedBox(width: width / 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(productList[index].type,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: height / 70)),
                                      SizedBox(height: height / 200),
                                      Text(productList[index].name,
                                          style:
                                              TextStyle(color: Colors.black)),
                                      SizedBox(height: height / 200),
                                      Text(productList[index].rate,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: height / 50)),
                                      SizedBox(height: height / 200),
                                      Text(productList[index].offer,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: height / 70)),
                                    ],
                                  ),
                                  SizedBox(width: width / 9),
                                  Switch(
                                    value: !productList[index].outOfStock,
                                    onChanged: (value) {
                                      setState(() {
                                        productList[index].outOfStock = !value;
                                      });
                                    },
                                    activeColor: Colors.white,
                                    activeTrackColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          );
                        else
                          return SizedBox(height: 0);
                      },
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(height: 20),
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
