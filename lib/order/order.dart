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
  @override
  Widget build(BuildContext context) {
    OrderList sampleOrderPacking = OrderList(
        price: 200,
        addressReciever: 'Address',
        mobileNumber: '99944433322',
        recieverName: 'Reciever',
        paymentStatus: 'Paid',
        orderStatus: 'Packing',
        productName: 'Product Name',
        orderNumber: 1234);

    OrderList sampleOrderReady = OrderList(
        price: 200,
        addressReciever: 'Address',
        mobileNumber: '99944433322',
        recieverName: 'Reciever',
        paymentStatus: 'Paid',
        orderStatus: 'Ready',
        productName: 'Product Name',
        orderNumber: 1234);
    OrderList sampleOrderShipping = OrderList(
        price: 200,
        addressReciever: 'Address',
        mobileNumber: '99944433322',
        recieverName: 'Reciever',
        paymentStatus: 'Paid',
        orderStatus: 'Shipping',
        productName: 'Product Name',
        orderNumber: 1234);

    List<OrderList> orderList = [
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderShipping,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderReady,
      sampleOrderPacking,
      sampleOrderPacking,
      sampleOrderPacking,
      sampleOrderPacking,
      sampleOrderPacking,
      sampleOrderPacking,
      sampleOrderPacking,
      sampleOrderPacking,
      sampleOrderPacking,
      sampleOrderPacking,
    ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: orderList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  if (orderList[index].orderStatus == widget.orderStatus ||
                      widget.orderStatus == 'Placed') {
                    return Column(
                      children: [
                        Center(
                          child: Container(
                            height: height / 3,
                            width: width / 1.2,
                            padding: EdgeInsets.symmetric(
                                horizontal: width / 20, vertical: height / 80),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(height / 80),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order #${orderList[index].orderNumber}',
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
                                        style:
                                            TextStyle(fontSize: height / 70)),
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
                                        style:
                                            TextStyle(fontSize: height / 70)),
                                    Text('${orderList[index].paymentStatus}',
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
                                        padding: EdgeInsets.all(height / 180),
                                        child: Icon(Icons.location_on_rounded)),
                                    SizedBox(width: width / 30),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(orderList[index].addressReciever,
                                            style: TextStyle(
                                                fontSize: height / 70),
                                            textAlign: TextAlign.left),
                                        SizedBox(height: height / 200),
                                        Text(orderList[index].mobileNumber,
                                            style: TextStyle(
                                                fontSize: height / 70),
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
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height / 30),
                      ],
                    );
                  } else
                    return SizedBox(height: 0);
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}
