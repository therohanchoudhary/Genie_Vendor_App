import 'package:flutter/material.dart';
import 'package:vendor_app/order/order.dart';

class TabBarOrder extends StatefulWidget {
  @override
  _TabBarOrderState createState() => _TabBarOrderState();
}

class _TabBarOrderState extends State<TabBarOrder> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: height/20),
            Center(
                child: Text('Welcome User',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                        fontWeight: FontWeight.bold))),
            SizedBox(height: height / 60),

            TabBar(
              tabs: [
                Tab(
                    child: Text('Placed(60)',
                        style: TextStyle(
                            color: Colors.black, fontSize: width / 50))),
                Tab(
                    child: Text('Packing(10)',
                        style: TextStyle(
                            color: Colors.black, fontSize: width / 50))),
                Tab(
                    child: Text('Ready(20)',
                        style: TextStyle(
                            color: Colors.black, fontSize: width / 50))),
                Tab(
                    child: Text('Shipping(20)',
                        style: TextStyle(
                            color: Colors.black, fontSize: width / 53))),
              ],
            ),
            Container(
                color: Colors.grey[600], width: double.infinity, height: 2),

            Expanded(
              child: TabBarView(
                children: [
                  OrderScreen(orderStatus: 'Placed'),
                  OrderScreen(orderStatus: 'Packing'),
                  OrderScreen(orderStatus: 'Ready'),
                  OrderScreen(orderStatus: 'Shipping'),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
