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

class ProductFirebase {
  final String brand;
  final String category;
  final String desc;
  final String discount;
  final List freq;
  final String id;
  final List<String> img;
  final bool isveg;
  final double lat;
  final String life;
  final double long;
  final String manufacturer;
  final String marketedby;
  final int mprice;
  final String oprice;
  final List reviews;
  final String rnr;
  final String seller;
  final String sellerid;
  final String units;
  final List values;
  bool outOfStock;

  ProductFirebase({
    this.id,
    this.category,
    this.freq,
    this.values,
    this.brand,
    this.desc,
    this.discount,
    this.img,
    this.isveg,
    this.lat,
    this.life,
    this.long,
    this.manufacturer,
    this.marketedby,
    this.mprice,
    this.oprice,
    this.outOfStock,
    this.reviews,
    this.rnr,
    this.seller,
    this.sellerid,
    this.units,
  });
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductList> productList = [];
  List<ProductFirebase> productsFirebase = [];
  bool noProducts = false;

  Future _getData(String email) async {
    var _db =
        await FirebaseFirestore.instance.collection("shop").doc('2').get();
    var id;
    await FirebaseFirestore.instance
        .collection("registerSeller")
        .doc(email)
        .get()
        .then((value) => id = value.data()["id"]);

    for (int i = 0; i < _db.data()["products"].length; i++) {
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
        productsFirebase.add(ProductFirebase(
          id: _db.data()["products"][i]["id"],
          isveg: _db.data()["products"][i]["isveg"],
          category: _db.data()["products"][i]["category"],
          rnr: _db.data()["products"][i]["rnr"],
          brand: _db.data()["products"][i]["brand"],
          lat: _db.data()["products"][i]["lat"],
          values: _db.data()["products"][i]["values"],
          reviews: _db.data()["products"][i]["reviews"],
          outOfStock: _db.data()["products"][i]["outOfStock"] == true,
          marketedby: _db.data()["products"][i]["marketedby"],
          manufacturer: _db.data()["products"][i]["manufacturer"],
          discount: _db.data()["products"][i]["discount"],
          units: _db.data()["products"][i]["units"],
          seller: _db.data()["products"][i]["seller"],
          sellerid: _db.data()["products"][i]["sellerid"],
          desc: _db.data()["products"][i]["desc"],
          img: _db.data()["products"][i]["img"],
          life: _db.data()["products"][i]["life"],
          oprice: _db.data()["products"][i]["oprice"],
          long: _db.data()["products"][i]["long"],
          mprice: _db.data()["products"][i]["mprice"],
          freq: _db.data()["products"][i]["freq"],
        ));

        setState(() {});
        print("Length ${productsFirebase.length}");
      }
      setState(() {
        noProducts = true;
      });
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
                                    value: productList[index].outOfStock,
                                    onChanged: (value) async {
                                      setState(() {
                                        print(value);
                                        productsFirebase[index].outOfStock =
                                            true;
                                      });
                                      await FirebaseFirestore.instance
                                          .collection('shop')
                                          .doc('2')
                                          .update(
                                              {"products": productsFirebase});
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
                : noProducts == false
                    ? Column(
                        children: [
                          SizedBox(height: 20),
                          Center(child: CircularProgressIndicator()),
                        ],
                      )
                    : Center(
                        child: widget.outOfStock == true
                            ? Text('No Products are out of stock.',
                                textAlign: TextAlign.center)
                            : Text('No Products registered by you.',
                                textAlign: TextAlign.center),
                      ),
          ],
        ),
      ),
    );
  }
}
