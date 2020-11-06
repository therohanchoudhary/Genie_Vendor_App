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
  final List img;
  final bool isveg;
  final lat;
  final String life;
  final long;
  final String manufacturer;
  final String marketedby;
  final int mprice;
  final String name;
  final int oprice;
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
    this.name,
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
        name: _db.data()["products"][i]["name"],
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

      if (_db.data()["products"][i]["sellerid"].toString() == id.toString() &&
          _db.data()["products"][i]["category"].toString() == widget.category &&
          _db.data()["products"][i]["outOfStock"] == widget.outOfStock) {
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
    if (productList.length == 0)
      setState(() {
        noProducts = true;
      });
  }

  @override
  void initState() {
    super.initState();
    User user = FirebaseAuth.instance.currentUser;
    _getData(user.email);
    setState(() {});
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
                                    value: !productList[index].outOfStock,
                                    onChanged: (value) async {
                                      setState(() {
                                        print(!widget.outOfStock);
                                        print(productList[index].firebaseIndex);
                                        productsFirebase[productList[index]
                                                .firebaseIndex]
                                            .outOfStock = !widget.outOfStock;
                                      });

                                      await FirebaseFirestore.instance
                                          .collection('shop')
                                          .doc('2')
                                          .update({
                                        "products": FieldValue.arrayRemove([
                                          {
                                            "category": productsFirebase[
                                                    productList[
                                                            productList[index]
                                                                .firebaseIndex]
                                                        .firebaseIndex]
                                                .category,
                                            "outOfStock": widget.outOfStock,
                                            "brand": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .brand,
                                            "desc": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .desc,
                                            "discount": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .discount,
                                            "name": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .name,
                                            "oprice": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .oprice,
                                            "isveg": true,
                                            "life": "5 years",
                                            "lat": 28.0,
                                            "long": 72.0,
                                            "mprice": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .mprice,
                                            "id":
                                                "${productsFirebase[productList[index].firebaseIndex].id}",
                                            "sellerid":
                                                "${productsFirebase[productList[index].firebaseIndex].sellerid}",
                                            "seller": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .seller,
                                            "rnr": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .rnr,
                                            "freq": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .freq,
                                            "manufacturer": "Manufacturer",
                                            "marketedby": "Marketer",
                                            "img": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .img,
                                            "units": "box",
                                            "reviews": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .reviews,
                                            "values": [1, 2],
                                          }
                                        ]),
                                      });
                                      await FirebaseFirestore.instance
                                          .collection('shop')
                                          .doc('2')
                                          .update({
                                        "products": FieldValue.arrayUnion([
                                          {
                                            "category": productsFirebase[
                                                    productList[
                                                            productList[index]
                                                                .firebaseIndex]
                                                        .firebaseIndex]
                                                .category,
                                            "outOfStock": !widget.outOfStock,
                                            "brand": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .brand,
                                            "desc": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .desc,
                                            "discount": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .discount,
                                            "name": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .name,
                                            "oprice": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .oprice,
                                            "isveg": true,
                                            "life": "5 years",
                                            "lat": 28.0,
                                            "long": 72.0,
                                            "mprice": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .mprice,
                                            "id":
                                                "${productsFirebase[productList[index].firebaseIndex].id}",
                                            "sellerid":
                                                "${productsFirebase[productList[index].firebaseIndex].sellerid}",
                                            "seller": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .seller,
                                            "rnr": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .rnr,
                                            "freq": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .freq,
                                            "manufacturer": "Manufacturer",
                                            "marketedby": "Marketer",
                                            "img": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .img,
                                            "units": "box",
                                            "reviews": productsFirebase[
                                                    productList[index]
                                                        .firebaseIndex]
                                                .reviews,
                                            "values": [1, 2],
                                          }
                                        ]),
                                      });
                                      Navigator.pop(context);
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
                            ? Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text('No Products are out of stock.',
                                    textAlign: TextAlign.center),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text('No Products registered by you.',
                                    textAlign: TextAlign.center),
                              ),
                      ),
          ],
        ),
      ),
    );
  }
}
