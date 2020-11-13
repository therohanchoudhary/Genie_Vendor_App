import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  final String orderStatus;

  OrderScreen({this.orderStatus});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class OrderList {
  int orderNumber;
  String paymentStatus;
  String orderStatus;
  String recieverName;
  String productName;
  int price;
  int firebaseIndex;
  String documentID;
  String id;
  String addressReciever;
  String mobileNumber;

  OrderList(
      {this.price,
      this.addressReciever,
      this.mobileNumber,
      this.id,
      this.firebaseIndex,
      this.orderNumber,
      this.productName,
      this.recieverName,
      this.documentID,
      this.orderStatus,
      this.paymentStatus});
}

class OrdersFirebase {
  String brand;
  String caddress;
  String category;
  var clat;
  var clong;
  String cname;
  String date;
  String desc;
  String discount;
  List freq;
  String id;
  List img;
  bool isveg;
  String life;
  String manufacturer;
  String marketedby;
  int mprice;
  String name;
  int oprice;
  var olat;
  var olong;
  var orderid;
  String paymode;
  bool reviewed;
  List reviews;
  String rnr;
  var selected;
  String seller;
  String sellerid;
  var stars;
  String status;
  String units;
  List values;

  OrdersFirebase(
      {this.id,
      this.orderid,
      this.status,
      this.brand,
      this.name,
      this.values,
      this.units,
      this.marketedby,
      this.life,
      this.manufacturer,
      this.isveg,
      this.reviews,
      this.img,
      this.olat,
      this.olong,
      this.rnr,
      this.sellerid,
      this.mprice,
      this.oprice,
      this.discount,
      this.category,
      this.seller,
      this.desc,
      this.freq,
      this.date,
      this.caddress,
      this.clat,
      this.clong,
      this.cname,
      this.paymode,
      this.reviewed,
      this.selected,
      this.stars});
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrderList> orderList = [];

  bool showUltimateSpinner = false;

  List<OrdersFirebase> firebaseOrderProductList = [];
  bool noEntries = false;

  Future onTapChangeStatus(String status, String doc, int firebaseIndex) async {
    setState(() {
      showUltimateSpinner = true;
    });
    var a = firebaseOrderProductList[firebaseIndex];
    print(a.status);
    await FirebaseFirestore.instance.collection('orders').doc(doc).update({
      "products": FieldValue.arrayRemove([
        {
          "brand": a.brand,
          "caddress": a.caddress,
          "category": a.category,
          "clat": a.clat,
          "clong": a.clong,
          "cname": a.cname,
          "date": a.date,
          "desc": a.desc,
          "discount": a.discount,
          "freq": a.freq,
          "id": a.id,
          "img": a.img,
          "isveg": a.isveg,
          "life": a.life,
          "manufacturer": a.manufacturer,
          "marketedby": a.marketedby,
          "mprice": a.mprice,
          "name": a.name,
          "oprice": a.oprice,
          "olat": a.olat,
          "olong": a.olong,
          "orderid": a.orderid,
          "paymode": a.paymode,
          "reviews": a.reviews,
          "reviewed": a.reviewed,
          "rnr": a.rnr,
          "selected": a.selected,
          "seller": a.seller,
          "sellerid": a.sellerid,
          "stars": a.stars,
          "status": a.status,
          "units": a.units,
          "values": a.values,
        }
      ]),
    });

    if (a.status.toUpperCase() == 'PACKING') {
      await FirebaseFirestore.instance
          .collection('deliveryLog')
          .doc("${a.orderid}")
          .set({
        "orderNumber": a.orderid,
        "productName": a.name,
        "paymentMode": a.paymode,
        "seller": a.sellerid,
        "sellerEmail": FirebaseAuth.instance.currentUser.email,
        "customerName": a.cname,
        "customerAddress": a.caddress,
      });
    }

    await FirebaseFirestore.instance.collection('orders').doc(doc).update({
      "products": FieldValue.arrayUnion([
        {
          "brand": a.brand,
          "caddress": a.caddress,
          "category": a.category,
          "clat": a.clat,
          "clong": a.clong,
          "cname": a.cname,
          "date": a.date,
          "desc": a.desc,
          "discount": a.discount,
          "freq": a.freq,
          "id": a.id,
          "img": a.img,
          "isveg": a.isveg,
          "life": a.life,
          "manufacturer": a.manufacturer,
          "marketedby": a.marketedby,
          "mprice": a.mprice,
          "name": a.name,
          "oprice": a.oprice,
          "olat": a.olat,
          "olong": a.olong,
          "orderid": a.orderid,
          "paymode": a.paymode,
          "reviews": a.reviews,
          "reviewed": a.reviewed,
          "rnr": a.rnr,
          "selected": a.selected,
          "seller": a.seller,
          "sellerid": a.sellerid,
          "stars": a.stars,
          "status": status,
          "units": a.units,
          "values": a.values,
        }
      ]),
    });
    setState(() {
      showUltimateSpinner = false;
    });
  }

  Future _getData(String email) async {
    var id;

    await FirebaseFirestore.instance
        .collection("registerSeller")
        .doc(email)
        .get()
        .then((value) => id = value.data()["id"]);

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("orders").get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i].data();
      for (int j = 0; j < a["products"].length; j++) {
        firebaseOrderProductList.add(OrdersFirebase(
            brand: a["products"][j]["brand"],
            caddress: a["products"][j]["caddress"],
            category: a["products"][j]["category"],
            clat: a["products"][j]["clat"],
            clong: a["products"][j]["clong"],
            cname: a["products"][j]["cname"],
            date: a["products"][j]["date"],
            desc: a["products"][j]["desc"],
            discount: a["products"][j]["discount"],
            freq: a["products"][j]["freq"],
            id: a["products"][j]["id"],
            img: a["products"][j]["img"],
            isveg: a["products"][j]["isveg"],
            life: a["products"][j]["life"],
            marketedby: a["products"][j]["marketedby"],
            manufacturer: a["products"][j]["manufacturer"],
            mprice: a["products"][j]["mprice"],
            name: a["products"][j]["name"],
            oprice: a["products"][j]["oprice"],
            olat: a["products"][j]["olat"],
            olong: a["products"][j]["olong"],
            orderid: a["products"][j]["orderid"],
            paymode: a["products"][j]["paymode"],
            reviews: a["products"][j]["reviews"],
            reviewed: a["products"][j]["reviewed"],
            rnr: a["products"][j]["rnr"],
            sellerid: a["products"][j]["sellerid"],
            seller: a["products"][j]["seller"],
            selected: a["products"][j]["selected"],
            stars: a["products"][j]["stars"],
            status: a["products"][j]["status"],
            units: a["products"][j]["units"],
            values: a["products"][j]["values"]));
        if (a["products"][j]["sellerid"].toString() == "$id") {
          orderList.add(OrderList(
              orderNumber: a["products"][j]["orderid"],
              firebaseIndex: firebaseOrderProductList.length - 1,
              price: a["products"][j]["oprice"],
              id: a["products"][j]["id"],
              documentID: querySnapshot.docs[i].id,
              addressReciever: a["products"][j]["caddress"],
              mobileNumber: "9999999999",
              paymentStatus:
                  a["products"][j]["paymode"].toString().toUpperCase() ==
                          "CASH ON DELIVERY"
                      ? "Cash on Delivery"
                      : "Paid",
              recieverName: a["products"][j]["cname"],
              orderStatus: a["products"][j]["status"],
              productName: a["products"][j]["name"]));
          if (mounted) setState(() {});
        }
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

    int entriesTotal = 1000000;
    _buttonContainer(String text, Color color, var h, var w) {
      return Container(
        height: height / h,
        width: width / w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(height),
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      );
    }

    if (mounted) setState(() {});
    return SafeArea(
        child: Scaffold(
      body: orderList.length != 0
          ? showUltimateSpinner == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      if ((orderList[index].orderStatus ==
                              widget.orderStatus) ||
                          (widget.orderStatus == 'All') ||
                          (orderList[index].orderStatus == "Waiting.." &&
                              widget.orderStatus == 'New Order')) {
                        return Column(
                                children: [
                                  Container(
                                    height: height / 2.5,
                                    width: width / 1.2,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 20,
                                        vertical: height / 80),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius:
                                          BorderRadius.circular(height / 80),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Order #${orderList[index].orderNumber}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: height / 70)),
                                          SizedBox(height: height / 90),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(orderList[index].orderStatus,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: height / 70)),
                                              Text(
                                                  orderList[index].recieverName,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: height / 70)),
                                            ],
                                          ),
                                          SizedBox(height: height / 70),
                                          Text(orderList[index].productName,
                                              style: TextStyle(
                                                  fontSize: height / 50,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: height / 50),
                                          Row(
                                            children: [
                                              Text('Total Bill: ₹ ',
                                                  style: TextStyle(
                                                      fontSize: height / 70)),
                                              Text('${orderList[index].price}',
                                                  style: TextStyle(
                                                      fontSize: height / 70,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          SizedBox(height: height / 100),
                                          Row(
                                            children: [
                                              Text('Status: ',
                                                  style: TextStyle(
                                                      fontSize: height / 70)),
                                              Text(
                                                  '${orderList[index].paymentStatus}',
                                                  style: TextStyle(
                                                      fontSize: height / 70,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          SizedBox(height: height / 60),
                                          Row(
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey[400])),
                                                  padding: EdgeInsets.all(
                                                      height / 180),
                                                  child: Icon(Icons
                                                      .location_on_rounded)),
                                              SizedBox(width: width / 30),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: width / 1.8,
                                                    child: Text(
                                                        orderList[index]
                                                            .addressReciever,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize:
                                                                height / 70),
                                                        textAlign:
                                                            TextAlign.left),
                                                  ),
                                                  SizedBox(
                                                      height: height / 200),
                                                  Text(
                                                      orderList[index]
                                                          .mobileNumber,
                                                      style: TextStyle(
                                                          fontSize:
                                                              height / 90),
                                                      textAlign:
                                                          TextAlign.left),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: height / 60),
                                          orderList[index].orderStatus ==
                                                  'Packing'
                                              ? Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      onTapChangeStatus(
                                                          "Shipping",
                                                          orderList[index]
                                                              .documentID,
                                                          orderList[index]
                                                              .firebaseIndex);

                                                      orderList[index]
                                                              .orderStatus =
                                                          'Shipping';
                                                      if (mounted)
                                                        setState(() {});
                                                    },
                                                    child: _buttonContainer(
                                                        'Order Ready',
                                                        Colors.blue,
                                                        15,
                                                        2.3),
                                                  ),
                                                )
                                              : Container(),
                                          orderList[index].orderStatus ==
                                                  'Delivered'
                                              ? Center(
                                                  child: _buttonContainer(
                                                      'Delivered',
                                                      Colors.grey,
                                                      15,
                                                      2.3))
                                              : Container(),
                                          orderList[index].orderStatus ==
                                                  'Shipping'
                                              ? Center(
                                                  child: _buttonContainer(
                                                      'Order Ready',
                                                      Colors.grey,
                                                      15,
                                                      2.3))
                                              : Container(),
                                          orderList[index].orderStatus ==
                                                      'Waiting..' ||
                                                  orderList[index]
                                                          .orderStatus ==
                                                      'Return' // Waiting.. is new order
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                      Center(
                                                        child: GestureDetector(
                                                            onTap: () async {
                                                              onTapChangeStatus(
                                                                  orderList[index]
                                                                              .orderStatus ==
                                                                          'Waiting..'
                                                                      ? "Rejected Order"
                                                                      : "Rejected Refund",
                                                                  orderList[
                                                                          index]
                                                                      .documentID,
                                                                  orderList[
                                                                          index]
                                                                      .firebaseIndex);
                                                              setState(() {
                                                                orderList.remove(
                                                                    orderList[
                                                                        index]);
                                                              });
                                                              if (mounted)
                                                                setState(() {});
                                                            },
                                                            child:
                                                                _buttonContainer(
                                                                    'Reject',
                                                                    Colors.red,
                                                                    20,
                                                                    3)),
                                                      ),
                                                      Flexible(
                                                          child: SizedBox(
                                                              width:
                                                                  width / 30)),
                                                      Center(
                                                          child:
                                                              GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    onTapChangeStatus(
                                                                        orderList[index].orderStatus ==
                                                                                'Waiting..'
                                                                            ? "Packing"
                                                                            : "Accepted Refund",
                                                                        orderList[index]
                                                                            .documentID,
                                                                        orderList[index]
                                                                            .firebaseIndex);
                                                                    setState(
                                                                        () {
                                                                      orderList[index]
                                                                              .orderStatus =
                                                                          'Packing';
                                                                    });
                                                                  },
                                                                  child: _buttonContainer(
                                                                      'Accept',
                                                                      Colors
                                                                          .green,
                                                                      20,
                                                                      3)))
                                                    ])
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 50)
                                ],
                              );
                      } else
                        return Container();
                    },
                  ),
                )
              ],
            )
          : Center(
              child: entriesTotal == 0
                  ? Text('No pending orders.', textAlign: TextAlign.center)
                  : CircularProgressIndicator()),
    ));
  }
}
