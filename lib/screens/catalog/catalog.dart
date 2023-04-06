import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/blocs/product/product_bloc.dart';
import 'package:thriftly/main.dart';
import 'package:thriftly/model/category_model.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:thriftly/type/type_.dart';
import 'package:thriftly/widgets/Custom_Appbar.dart';
import 'package:thriftly/widgets/product_cards.dart';

import '../../widgets/Custom_bottombar.dart';

class CatalogScreen extends StatelessWidget with PreferredSizeWidget {
  static const String routeName = '/catalog';

  static Route route({required Category category, required ItemType type}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => CatalogScreen(
        category: category,
        type: type,
      ),
    );
  }

  final Category category;
  final ItemType type;

  const CatalogScreen({required this.category, required this.type});

  @override
  Widget build(BuildContext context) {
    final String typeString = type.toString().split('.').last;
    int numColumns = MediaQuery.of(context).size.width ~/ 200; // assuming each product card has a width of 200




    return Scaffold(
        appBar: CustomAppBar(
          title:category.name,
        ),
        //bottomNavigationBar: custom_bottom_nav(),
        body: BlocBuilder<ProductBloc , ProductState>(
              builder: (context, state) {
                if(state is ProductLoading){
                  return CircularProgressIndicator();
                }if(state is ProductLoaded){
                  final List<Product> categoryProducts = state.products
                      .where((product) => product.category == category.name && product.type == typeString )
                      .toList();
                  if (categoryProducts.isEmpty) {
                    return  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 120,
                            color: Colors.grey[500],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "No products found",
                            style: GoogleFonts.aBeeZee(textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),)

                          ),

                        ],
                      ),
                    );;
                  }


                  return
                      GridView.builder(
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.6,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,


                              ),
                              shrinkWrap: true,
                              itemCount: categoryProducts.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    child: product_card(
                                      products: categoryProducts[index],

                                    ),
                                  );

                              }



                  );
                } else {
                  return Text('Something is wrong');
                }
              }
          ),
        );

  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
