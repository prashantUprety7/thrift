import 'package:flutter/cupertino.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:thriftly/widgets/product_cards.dart';
import 'package:flutter/material.dart';
import 'package:thriftly/widgets/productslidercard.dart';

class product_slider extends StatelessWidget {
  final List<Product> products;
  const product_slider({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/catalog');
      },
     child: Container(
       height: MediaQuery.of(context).size.height * 0.42, // set the height based on screen size
       child: ListView.builder(
         shrinkWrap: true,
         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
         scrollDirection: Axis.horizontal,
         itemCount: products.length,
         itemBuilder: (context, index) {
           final screenWidth = MediaQuery.of(context).size.width;

           return Padding(
             padding: EdgeInsets.only(right: 10),
             child: SizedBox(
               width: screenWidth * 0.45, // set the width of the card based on screen size
               child: ProductSliderCard(
                 products: products[index],
               ),
             ),
           );
         },
       ),
     ),

    );
  }
}