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
  final int orderNumber;
  final String paymentStatus;
  final String orderStatus;
  final String recieverName;
  final String productName;
  final int price;
  final String addressReciever;
  final String mobileNumber;

  OrderList(
      {this.price,
      this.addressReciever,
      this.mobileNumber,
      this.orderNumber,
      this.productName,
      this.recieverName,
      this.orderStatus,
      this.paymentStatus});
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrderList> orderList = [];

  bool noEntries = false;

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
      var a = querySnapshot.docs[i];
      print(a.data());
      for (int j = 0; j < a.data()["products"].length; j++) {
        if (a.data()["products"][j]["sellerid"].toString() == "$id") {
          orderList.add(OrderList(
              orderNumber: a.data()["products"][j]["orderid"],
              price: a.data()["products"][j]["oprice"],
              addressReciever: a.data()["products"][j]["caddress"],
              mobileNumber: "9999999999",
              paymentStatus:
                  a.data()["products"][j]["paymode"].toString().toUpperCase() ==
                          "CASH ON DELIVERY"
                      ? "Cash on Delivery"
                      : "Paid",
              recieverName: a.data()["products"][j]["cname"],
              orderStatus: a.data()["products"][j]["status"],
              productName: a.data()["products"][j]["name"]));
          setState(() {});
        }
      }
    }

    setState(() {
      noEntries = orderList.length == 0;
    });
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
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: orderList.length != 0
            ? Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        if (orderList[index].orderStatus ==
                                widget.orderStatus ||
                            widget.orderStatus == 'Placed') {
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          Text(orderList[index].recieverName,
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
                                                  fontWeight: FontWeight.bold)),
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
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(height: height / 60),
                                      Row(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.grey[400])),
                                              padding:
                                                  EdgeInsets.all(height / 180),
                                              child: Icon(
                                                  Icons.location_on_rounded)),
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
                                                        fontSize: height / 70),
                                                    textAlign: TextAlign.left),
                                              ),
                                              SizedBox(height: height / 200),
                                              Text(
                                                  orderList[index].mobileNumber,
                                                  style: TextStyle(
                                                      fontSize: height / 90),
                                                  textAlign: TextAlign.left),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: height / 80),
                                      Center(
                                        child: Container(
                                          height: height / 15,
                                          width: width / 2.3,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(height),
                                          ),
                                          child: Center(
                                            child: Text('Order Ready',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: height / 50),
                            ],
                          );
                        } else
                          return SizedBox(height: 0);
                      },
                    ),
                  )
                ],
              )
            : Center(
                child: noEntries
                    ? Text('No pending orders.',
                        textAlign: TextAlign.center)
                    : CircularProgressIndicator()),
      ),
    ));
  }
}
