import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/product/product_bloc.dart';
import '../../model/productModel.dart';
import '../../widgets/product_cards.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SearchScreen(),
    );
  }

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  List<Product> _searchResults = [];

  void _onSearchButtonPressed() {
    BlocProvider.of<ProductBloc>(context).add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(width: 20),
            Expanded(
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 3.0,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 30),
            IconButton(
              icon: Icon(Icons.search, color: Colors.black,size: 30,),
              onPressed: _onSearchButtonPressed,
            ),
          ],
        ),
      ),
        body: _searchQuery.isEmpty
    ? Container(

    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 20),
          Text(
            'Search for products',
            style: GoogleFonts.aBeeZee(textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500],
            ),)
          ),
          SizedBox(height: 10),

        ],
      ),
    ),
    )
        : BlocBuilder<ProductBloc, ProductState>(
    builder: (context, state) {
    if (state is ProductLoading) {
    return Center(child: CircularProgressIndicator());
    } else if (state is ProductLoaded) {
      _searchResults = state.products
          .where((product) => product.name.toLowerCase().contains(_searchQuery))
          .toList();
      return _searchResults.isEmpty
          ? Center(
        child:Column(
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
              "No Results Found",
              style:GoogleFonts.aBeeZee(textStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
              ), )


            ),
            SizedBox(height: 10),

          ],
        ),
      )
          : Padding( padding: EdgeInsets.symmetric(vertical: 15,horizontal: 2),child:SingleChildScrollView(
            child: GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
        ),
        shrinkWrap: true,
        itemCount: _searchResults.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: product_card(
                products: _searchResults[index],
              ),
            );
        },
      ),
          ));
    } else {
      return Center(child: Text('Failed to load products'));
    }
    },
    ),

    );
  }
}