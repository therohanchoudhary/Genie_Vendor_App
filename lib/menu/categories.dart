import 'package:flutter/material.dart';
import 'package:vendor_app/menu/TabBarMenu.dart';
import 'package:vendor_app/menu/add_product.dart';

class CategoryScreen extends StatefulWidget {

  final String email;
  CategoryScreen({this.email});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> categoryList = [
      'Fruits &\nVegetables',
      'Non\nVegetarian',
      'Soft\nDrinks',
      'Cosmetics\n(Men)',
      'Spice &\nHerbs',
      'Cleaning &\nHousehold',
      'Electronics',
    ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    _gridCardWidget(int index) {
      return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => TabBarMenu())),
        child: Container(
            height: height / 4.7,
            width: width / 2.3,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(
                      width: width / 2.3,
                      height: height / 7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://st.depositphotos.com/1063437/2769/i/950/depositphotos_27699157-stock-photo-green-shopping-bag-with-grocery.jpg')))),
                ),
                SizedBox(height: height / 150),
                Text(categoryList[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontSize: height / 70)),
              ],
            )),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
                child: Text('Welcome User',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                        fontWeight: FontWeight.bold))),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categoryList.length ~/ 2,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _gridCardWidget(index * 2),
                        SizedBox(width: width / 30),
                        _gridCardWidget(index * 2 + 1),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
            categoryList.length % 2 == 1
                ? _gridCardWidget(categoryList.length - 1)
                : Container(),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => AddProduct(emailSeller: widget.email,))),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
