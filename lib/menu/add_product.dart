import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    _textField(String hintText, var keyBoardType) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: height / 40, vertical: height / 80),
        child: TextField(
          maxLines: hintText == 'Description' ? 1 : 1,
          keyboardType: keyBoardType,
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
              Stack(
                alignment: Alignment(1.8,1),
                children: [
                  Container(
                    height: height / 5,
                    width: width / 2,
                    child: Image.network(
                        'https://www.ocado.com/productImages/316/316751011_0_640x640.jpg?identifier=f5b98bc6a016e720dee27da65ec354ca'),
                  ),
                  Container(
                    height: height / 16,
                    width: height / 16,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: height / 20,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue[800], shape: BoxShape.rectangle),
                  )
                ],
              ),
              _textField('Category', TextInputType.name),
              _textField('Product Name', TextInputType.name),
              _textField('Price', TextInputType.number),
              _textField('Description', TextInputType.name),
              _textField('Offers', TextInputType.name),
              SizedBox(height: height / 40),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(1000)),
                    height: height / 15,
                    width: width / 1.8,
                    child: Center(
                        child: Text('Login',
                            style: TextStyle(
                                color: Colors.white, fontSize: height / 65))),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
