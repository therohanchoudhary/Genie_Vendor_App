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

class DropDownListItem {
  int value;
  String name;

  DropDownListItem(this.value, this.name);
}

class _AddProductState extends State<AddProduct> {
  bool showSpinner = false;
  int _value = 1;
  List<DropDownListItem> dropDownListItems = [
    DropDownListItem(1, 'Fruits & Vegetables'),
    DropDownListItem(2, 'Non Vegetarian'),
    DropDownListItem(3, 'Dairy Products'),
    DropDownListItem(4, 'Soft Drinks'),
    DropDownListItem(5, 'Cosmetics (Men)'),
    DropDownListItem(6, 'Cosmetics (Women)'),
    DropDownListItem(7, 'Spices & Herbs'),
    DropDownListItem(8, 'Cleaning & Household'),
    DropDownListItem(9, 'Baby Care'),
    DropDownListItem(10, 'Chocolates & Sweets'),
    DropDownListItem(11, 'Chips & Crisps'),
    DropDownListItem(13, 'Candies & Toffees'),
  ];
  TextStyle dropDownTextStyle = TextStyle(fontSize: 10);
  TextEditingController categoryEntered = TextEditingController();
  TextEditingController nameEntered = TextEditingController();
  TextEditingController priceEntered = TextEditingController();
  TextEditingController gstAmount = TextEditingController();
  TextEditingController deliveryCharge = TextEditingController();
  TextEditingController descriptionEntered = TextEditingController();
  TextEditingController offersEntered = TextEditingController();
  TextEditingController manufacturer = TextEditingController();
  TextEditingController marketed = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    _textField(String hintText, var keyBoardType, var controller) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: height / 40, vertical: height / 80),
        child: TextField(
          maxLines: hintText == 'Description' ? 4 : 1,
          keyboardType: keyBoardType,
          controller: controller,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(1000),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300], width: 2.0),
                borderRadius: BorderRadius.circular(
                    hintText == 'Description' ? 40 : 1000),
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
              SizedBox(height: 50),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Category',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  DropdownButton(
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Text("Fruits & Vegetables",
                              style: dropDownTextStyle),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child:
                              Text("Non Vegetarian", style: dropDownTextStyle),
                          value: 2,
                        ),
                        DropdownMenuItem(
                            child: Text("Dairy Products",
                                style: dropDownTextStyle),
                            value: 3),
                        DropdownMenuItem(
                            child:
                                Text("Soft Drinks", style: dropDownTextStyle),
                            value: 4),
                        DropdownMenuItem(
                            child: Text("Cosmetics (Men)",
                                style: dropDownTextStyle),
                            value: 5),
                        DropdownMenuItem(
                            child: Text("Cosmetics (Women)",
                                style: dropDownTextStyle),
                            value: 6),
                        DropdownMenuItem(
                            child: Text("Spices & Herbs",
                                style: dropDownTextStyle),
                            value: 7),
                        DropdownMenuItem(
                            child: Text("Cleaning & Household",
                                style: dropDownTextStyle),
                            value: 8),
                        DropdownMenuItem(
                            child: Text("Baby Care", style: dropDownTextStyle),
                            value: 9),
                        DropdownMenuItem(
                            child: Text("Chocolates & Sweets",
                                style: dropDownTextStyle),
                            value: 10),
                        DropdownMenuItem(
                            child: Text("Chips & Crisps",
                                style: dropDownTextStyle),
                            value: 11),
                        DropdownMenuItem(
                            child: Text("Candies & Toffees",
                                style: dropDownTextStyle),
                            value: 12),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      }),
                ],
              ),
              _textField('Product Name', TextInputType.name, nameEntered),
              _textField('Price Amount', TextInputType.number, priceEntered),
              _textField('GST Amount', TextInputType.number, gstAmount),
              _textField(
                  'Delivery Charge', TextInputType.number, deliveryCharge),
              _textField('Description', TextInputType.name, descriptionEntered),
              _textField(
                  'Offer (Discount%)', TextInputType.number, offersEntered),
              _textField('Manufacturer', TextInputType.name, manufacturer),
              _textField('Marketed By', TextInputType.name, marketed),
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
                    sellerName = value.data()["name"].toString().toUpperCase();
                  });
                  x++;
                  await FirebaseFirestore.instance
                      .collection("registerSeller")
                      .doc(widget.emailSeller)
                      .update({"productsUploaded": x});
                  print(x);
                  List freq = [];

                  if (nameEntered.text != null &&
                      nameEntered.text != "" &&
                      descriptionEntered.text != null &&
                      descriptionEntered.text != "" &&
                      offersEntered.text != null &&
                      offersEntered.text != "" &&
                      priceEntered.text != null &&
                      priceEntered.text != "" &&
                      gstAmount.text != null &&
                      gstAmount.text != "" &&
                      deliveryCharge.text != null &&
                      deliveryCharge.text != "" &&
                      manufacturer.text != null &&
                      manufacturer.text!="" &&
                      marketed.text != null &&
                      marketed.text!="" &&
                      widget.url1 != null &&
                      widget.url2 != null &&
                      widget.url3 != null &&
                      widget.url4 != null) {
                    int mPriceEntered = int.parse(priceEntered.text);
                    int gst = int.parse(gstAmount.text);
                    int discount = int.parse(offersEntered.text);
                    int deliveryCharges = int.parse(deliveryCharge.text);

                    List reviews = [];
                    if (_value == 12) _value = 13;
                    await FirebaseFirestore.instance
                        .collection('shop')
                        .doc('${_value - 1}')
                        .update({
                      "products": FieldValue.arrayUnion([
                        {
                          "category": _value == 13
                              ? dropDownListItems[_value - 2].name
                              : dropDownListItems[_value - 1].name,
                          "brand": nameEntered.text,
                          "desc": descriptionEntered.text,
                          "discount": offersEntered.text + "%",
                          "name": nameEntered.text,
                          "mprice": mPriceEntered + gst + deliveryCharges,
                          "isveg": _value != 2,
                          "life": "5 years",
                          "lat": 28.0,
                          "long": 72.0,
                          "oprice": (((mPriceEntered + gst) *
                                      (100 - discount) /
                                      100) +
                                  deliveryCharges)
                              .toInt(),
                          "id": "${id}_$x",
                          "sellerid": "$id",
                          "seller": sellerName,
                          "rnr": "Refund Policy",
                          "freq": freq,
                          "outOfStock": false,
                          "manufacturer": manufacturer.text,
                          "marketedby": marketed.text,
                          "img": [
                            widget.url1,
                            widget.url2,
                            widget.url3,
                            widget.url4
                          ],
                          "units": "box",
                          "reviews": reviews,
                          "gstAmount": gst,
                          "deliveryAmount": deliveryCharges,
                          "values": [1, 2],
                        }
                      ]),
                    });
                    UsefulMethods().showToast(
                        "Product ${nameEntered.text.toUpperCase()} has been added successfully.");
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
                            child: Text('Upload',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height / 65))))
                    : CircularProgressIndicator(),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
