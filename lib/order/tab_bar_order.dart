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

    TextStyle tabTextStyle = TextStyle(color: Colors.black, fontSize: width / 72);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: height / 20),
            Center(
                child: Text('Welcome Vendor',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                        fontWeight: FontWeight.bold))),
            SizedBox(height: height / 60),
            TabBar(
              tabs: [
                Tab(
                    child: Text('All',
                        style: tabTextStyle)),
                Tab(
                    child: Text('New Order',
                        style: tabTextStyle,textAlign: TextAlign.center,)),
                Tab(
                    child: Text('Packing',
                        style: tabTextStyle)),
                Tab(
                    child: Text('Shipping',
                        style: tabTextStyle)),
                Tab(
                    child: Text('Delivered',
                        style: tabTextStyle)),
                Tab(
                    child: Text('Return',
                        style: tabTextStyle)),
              ],
            ),
            Container(
                color: Colors.grey[600], width: double.infinity, height: 2),
            Expanded(
              child: TabBarView(
                children: [
                  OrderScreen(orderStatus: 'All'),
                  OrderScreen(orderStatus: 'New Order'),
                  OrderScreen(orderStatus: 'Packing'),
                  OrderScreen(orderStatus: 'Shipping'),
                  OrderScreen(orderStatus: 'Delivered'),
                  OrderScreen(orderStatus: 'Return'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
