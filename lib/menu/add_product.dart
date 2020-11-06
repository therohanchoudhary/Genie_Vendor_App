import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/bottom_navigation_bar.dart';
import 'package:vendor_app/useful_methods.dart';
import 'add_product_image.dart';

class AddProduct extends StatefulWidget {
  final String emailSeller;
  final String url1, url2, url3, url4;

  AddProduct({this.emailSeller, this.url1, this.url2, this.url3, this.url4});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool showSpinner = false;

  TextEditingController categoryEntered = TextEditingController();
  TextEditingController nameEntered = TextEditingController();
  TextEditingController priceEntered = TextEditingController();
  TextEditingController descriptionEntered = TextEditingController();
  TextEditingController offersEntered = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    _textField(String hintText, var keyBoardType, var controller) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: height / 40, vertical: height / 80),
        child: TextField(
          maxLines: hintText == 'Description' ? 1 : 1,
          keyboardType: keyBoardType,
          controller: controller,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(1000),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300], width: 2.0),
                borderRadius: BorderRadius.circular(1000),
              ),
              filled: true,
              isDense: true,
              contentPadding: EdgeInsets.all(height / 40),
              hintStyle:
                  TextStyle(color: Colors.grey[500], fontSize: height / 80),
              hintText: hintText,
              fillColor: Colors.grey[300]),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: SizedBox(width: 1000)),
                  Flexible(child: SizedBox(width: 1000)),
                  Flexible(child: SizedBox(width: 1000)),
                  Flexible(child: SizedBox(width: 1000)),
                  Container(
                    height: height / 5,
                    width: width / 2,
                    child: widget.url1 == null
                        ? Center(
                            child: Text('Add images first.\nClick + button.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12)))
                        : Image.network(widget.url1),
                  ),
                  Flexible(child: SizedBox(width: 1000)),
                  InkWell(
                    onTap: () async {
                      var xx;
                      print(widget.emailSeller);
                      await FirebaseFirestore.instance
                          .collection("registerSeller")
                          .doc(widget.emailSeller)
                          .get()
                          .then((value) {
                        xx = value.data()["productsUploaded"];
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProductAddImage(
                                      documentName: xx.toString(),
                                      email: widget.emailSeller)));
                    },
                    child: Container(
                      height: height / 16,
                      width: height / 16,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: height / 20,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue[800], shape: BoxShape.rectangle),
                    ),
                  ),
                  Flexible(child: SizedBox(width: 1000)),
                ],
              ),
              _textField('Category', TextInputType.name, categoryEntered),
              _textField('Product Name', TextInputType.name, nameEntered),
              _textField('Price', TextInputType.number, priceEntered),
              _textField('Description', TextInputType.name, descriptionEntered),
              _textField(
                  'Offers (Discount%)', TextInputType.number, offersEntered),
              SizedBox(height: height / 40),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  int x;
                  var id;
                  String sellerName;
                  await FirebaseFirestore.instance
                      .collection("registerSeller")
                      .doc(widget.emailSeller)
                      .get()
                      .then((value) {
                    x = value.data()["productsUploaded"];
                    id = value.data()["id"];
                    sellerName = value
                        .data()["productsUploaded"]
                        .toString()
                        .toUpperCase();
                  });
                  x++;
                  await FirebaseFirestore.instance
                      .collection("registerSeller")
                      .doc(widget.emailSeller)
                      .update({"productsUploaded": x});
                  print(x);
                  List freq = [];

                  if (categoryEntered.text != null &&
                      categoryEntered.text != "" &&
                      nameEntered.text != null &&
                      nameEntered.text != "" &&
                      descriptionEntered.text != null &&
                      descriptionEntered.text != "" &&
                      offersEntered.text != null &&
                      offersEntered.text != "" &&
                      priceEntered.text != null &&
                      priceEntered.text != "" &&
                      widget.url1 != null &&
                      widget.url2 != null &&
                      widget.url3 != null &&
                      widget.url4 != null) {
                    int mPriceEntered = int.parse(priceEntered.text);
                    List reviews = [];
                    await FirebaseFirestore.instance
                        .collection('shop')
                        .doc('2')
                        .update({
                      "products": FieldValue.arrayUnion([
                        {
                          "category": categoryEntered.text,
                          "brand": nameEntered.text,
                          "desc": descriptionEntered.text,
                          "discount": offersEntered.text,
                          "name": nameEntered.text,
                          "oprice": mPriceEntered,
                          "isveg": true,
                          "life": "5 years",
                          "lat": 28.0,
                          "long": 72.0,
                          "mprice": mPriceEntered,
                          "id": "${id}_$x",
                          "sellerid": "$id",
                          "seller": sellerName,
                          "rnr": "Refund Policy",
                          "freq": freq,
                          "outOfStock": false,
                          "manufacturer": "Manufacturer",
                          "marketedby": "Marketer",
                          "img": [
                            widget.url1,
                            widget.url2,
                            widget.url3,
                            widget.url4
                          ],
                          "units": "box",
                          "reviews": reviews,
                          "values": [1, 2],
                        }
                      ]),
                    });
                    UsefulMethods()
                        .showToast("Product has been added successfully.");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                BottomNavigationBarScreen()));
                  } else {
                    UsefulMethods()
                        .showToast("Insufficient details &/or photos.");
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
                child: showSpinner == false
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(1000)),
                        height: height / 15,
                        width: width / 1.8,
                        child: Center(
                            child: Text('Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height / 65))))
                    : CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
