import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:thriftly/type/type_.dart';
import 'package:thriftly/type/type_.dart';
import 'package:thriftly/widgets/product_cards.dart';
import '../../model/category_model.dart';

class Image_slider extends StatelessWidget {
  final Category? category;
  final Product? product;
  final ItemType? type;


  const Image_slider({Key? key, this.category, this.product, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth * 1;

    return Container(
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

              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),

          ),
        ],
      ),
    );
  }
}