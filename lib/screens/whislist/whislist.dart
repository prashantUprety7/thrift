import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/main.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:thriftly/screens/whislist/wishlist%20card.dart';
import 'package:thriftly/widgets/Custom_Appbar.dart';

import '../../blocs/wishlist/wishlist_bloc.dart';
import '../../widgets/Custom_bottombar.dart';
import '../../widgets/product_cards.dart';

class WhislistScreen extends StatelessWidget with PreferredSizeWidget {
  static const String routeName = '/wishlist';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => WhislistScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Wishlist',

        ),
        //bottomNavigationBar: custom_bottom_nav(),
        body: BlocBuilder<WishListBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishListLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WishListLoaded) {
              if (state.wishlist.products.length == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite,color: Colors.red, size: 50),
                      SizedBox(height: 20),
                      Text('Your wishlist is empty!',
                        style:GoogleFonts.aBeeZee(textStyle:TextStyle(fontSize: 20, fontWeight: FontWeight.bold), )
                      ),
                      SizedBox(height: 10),

                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                          // Navigate to the products page
                        },
                        child: Text('Browse products',style: GoogleFonts.abel(),),style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(67, 65, 61, 1),
                          fixedSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      ),
                    ],
                  ),
                );

              }
              return GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 2.2,mainAxisSpacing: 20),
                  itemCount: state.wishlist.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                        child:WishlistCard (
                          product: state.wishlist.products[index],
                          isWishlist: true,
                        )
                    );
                  }
              );
            } else {
              return Text('Something went wrong');
            }
          },
        ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50.0);
}
