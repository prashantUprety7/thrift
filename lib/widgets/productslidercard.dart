
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/blocs/wishlist/wishlist_bloc.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductSliderCard extends StatelessWidget {

  final Product products;
  final bool isWishlist;


  const ProductSliderCard({
    Key? key,
    required this.products,
    this.isWishlist = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.45; // set the desired width of the card
    final cardHeight =cardWidth * 0.7;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: products);
      },
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,// add a fixed width value here
        child: Container(
      decoration: BoxDecoration(
      color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
        Expanded(
        flex: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
            child: Image.network(
              products.imageUrl,
              width: cardWidth,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 15,),
              Text(
                products.name,
                style:GoogleFonts.aBeeZee(textStyle:  TextStyle(
                  fontSize: 23,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,

                ),
                ),
                maxLines: 1,

              ),
              SizedBox(height: 5,),

              Row(
                children: [
                  Text(
                    'Condition : ',
                    style:GoogleFonts.aBeeZee(textStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ), )

                  ),
                  Text(
                    'New',
                    style:GoogleFonts.aBeeZee(textStyle:TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ), )

                  ),
                ],
              ),
              SizedBox(height: 3,),
              RatingBar.builder(
                initialRating: 4,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,

                        itemSize: 20,
                        itemPadding: EdgeInsets.symmetric(horizontal:1),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                        ),
                        onRatingUpdate: (index) {},
                      ),
                      SizedBox(height: 2,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rs ${products.price.toString()}',
                              style: GoogleFonts.aBeeZee(textStyle:TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ), )

                            ),
                            BlocBuilder<WishListBloc, WishlistState>(
                                builder: (context, state) {
                                  return IconButton(
                                      onPressed: () {
                                        final snackBar  = SnackBar(content: Text('Added to your Wishlist!'),duration: Duration(seconds: 1));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        context
                                            .read<WishListBloc>()
                                            .add(AddProductToWishList(products));
                                      },
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: Colors.red,
                                      ));
                                }),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      )],
            ),
          ),
        ),

    );

    /*Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / widthFactor,
              child: Image.network(
                products.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 131,
              left: leftPosition,
              height: 42,
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5 - 7,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(50),
                ),
              ),
            ),
            Positioned(
                top: 135,
                height: 45,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2 - 1.5,
                  height: 77,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(67,65,61, 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  products.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    fontSize: 17,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(width: 15,),
                        BlocBuilder<WishListBloc, WishlistState>(
                          builder: (context, state) {
                            if (state is WishListLoading) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is WishListLoaded) {
                              return isWishlist
                                  ? Expanded(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    final snackBar = SnackBar(
                                      content: Text('Removed from Wishlist!'),
                                      duration: Duration(seconds: 1),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    context
                                        .read<WishListBloc>()
                                        .add(RemoveProductFromWishList(products));
                                  },
                                ),
                              )


                                  : SizedBox(width: 0,);
                            } else {
                              return Text('Something went wrong');
                            }
                          },
                        ),

                      ],
                    ),
                  ),
                )),
          ],
        )*/
  }

}
