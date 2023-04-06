import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:thriftly/type/type_.dart';
import 'package:thriftly/type/type_.dart';
import '../../model/category_model.dart';

class Slider_carousel extends StatelessWidget {
  final Category? category;
  final Product? product;
  final ItemType? type;


  const Slider_carousel({Key? key, this.category, this.product, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth * 0.8;

    return InkWell(
      onTap: () {
        if (product == null ) {
          Map<String, dynamic> parameters = {
             'type': type,
            'category': category
          };
          Navigator.pushNamed(
            context,
            '/catalog',
            arguments:parameters);



        }

      },


      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: Image.network(
                  product == null ? category!.imageUrl : product!.imageUrl,
                  fit: BoxFit.cover,
                  width: imageWidth,
                ),
              ),
            ),
            Container(
              width: imageWidth,
              decoration: BoxDecoration(
                color: Color.fromRGBO(67, 65, 61, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Center(
                child: Text(
                  product == null ? category!.name.replaceAll("wear", "") : '',
                  style: GoogleFonts.aBeeZee(textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
