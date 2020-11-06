import 'package:flutter/material.dart';
import 'package:vendor_app/menu/product_list.dart';

class TabBarMenu extends StatefulWidget {
  final String category;

  TabBarMenu({this.category});

  @override
  _TabBarMenuState createState() => _TabBarMenuState();
}

class _TabBarMenuState extends State<TabBarMenu> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 50),
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
                    child: Text('All Items',
                        style: TextStyle(
                            color: Colors.black, fontSize: width / 35))),
                Tab(
                    child: Text('Out of Stock',
                        style: TextStyle(
                            color: Colors.black, fontSize: width / 35))),
              ],
            ),
            Container(
                color: Colors.grey[600], width: double.infinity, height: 2),
            Expanded(
              child: TabBarView(
                children: [
                  ProductListScreen(
                      outOfStock: false, category: widget.category),
                  ProductListScreen(
                      outOfStock: true, category: widget.category),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
