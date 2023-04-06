import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/wishlist/wishlist_bloc.dart';
import '../../model/productModel.dart';

class WishlistCard extends StatelessWidget {
  final Product product;
  final bool isWishlist;

  const WishlistCard({required this.product, required this.isWishlist});

  @override
  Widget build(BuildContext context) {
    return InkWell(

    onTap: () {
      Navigator.pushNamed(context, '/product', arguments: product);
    },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Text(
                          '\Seller: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Prashant',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      '\Rs ${product.price}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Roboto',
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '\Condition: ${'New'}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Roboto',
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 24,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.favorite, color: Colors.red),
                              const SizedBox(width: 5),
                              Text(
                                'Wishlist',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: BlocBuilder<WishListBloc, WishlistState>(
                                  builder: (context, state) {
                                    return IconButton(
                                      onPressed: () {
                                        final snackBar = SnackBar(
                                            content: Text('Removed from your Wishlist!',style: TextStyle(color: Colors.white,fontFamily: 'RobotoM'),),
                                            backgroundColor: Colors.red,

                                            duration: Duration(seconds: 1));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        context
                                            .read<WishListBloc>()
                                            .add(RemoveProductFromWishList(product));
                                      },
                                      icon: Icon(
                                        Icons.delete_outline_rounded,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )







                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
