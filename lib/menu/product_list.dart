import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  final bool outOfStock;

  ProductListScreen({this.outOfStock});

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

  ProductList(
      {this.offer,
      this.name,
      this.type,
      this.rate,
      this.outOfStock,
      this.image});
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductList inStockProduct = ProductList(
      offer: 'Offer',
      name: 'Product Name',
      rate: 'Rate',
      outOfStock: false,
      type: 'Type',
      image:
          'https://www.ocado.com/productImages/316/316751011_0_640x640.jpg?identifier=f5b98bc6a016e720dee27da65ec354ca');



  ProductList outOfStockProduct = ProductList(
      offer: 'Offer',
      name: 'Product Name',
      rate: 'Rate',
      outOfStock: true,
      type: 'Type',
      image:
          'https://www.ocado.com/productImages/316/316751011_0_640x640.jpg?identifier=f5b98bc6a016e720dee27da65ec354ca');

  @override
  Widget build(BuildContext context) {

    List<ProductList> productList = [
      inStockProduct,
      inStockProduct,
      inStockProduct,
      inStockProduct,
      inStockProduct,
      inStockProduct,
      inStockProduct,
      inStockProduct,
      inStockProduct,
      inStockProduct,
      inStockProduct,
      inStockProduct,
      inStockProduct,
      inStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
      outOfStockProduct,
    ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: width / 20),
                            Container(
                              height: height / 7,
                              width: width / 5,
                              child:
                                  Image.network('${productList[index].image}'),
                            ),
                            SizedBox(width: width / 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(productList[index].type,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: height / 70)),
                                SizedBox(height: height / 200),
                                Text(productList[index].name,
                                    style: TextStyle(color: Colors.black)),
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
                            SizedBox(width: width/9),
                            Switch(
                              value: productList[index].outOfStock,
                              onChanged: (value) {
                                setState(() {
                                  productList[index].outOfStock = value;
                                  print(productList[index].outOfStock);
                                });
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
          ],
        ),
      ),
    );
  }
}
