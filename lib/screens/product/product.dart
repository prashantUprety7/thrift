import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thriftly/blocs/wishlist/wishlist_bloc.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:thriftly/widgets/Custom_Appbar.dart';
import '../../controller/logincontroller.dart';
import '../../message/chatscreen.dart';
import '../../services/auth_service/auth_wrapper.dart';
import '../../widgets/banner.dart';
import '../../widgets/productimages.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatelessWidget with PreferredSizeWidget {


  static const String routeName = '/product';
  static Route route({required Product product}) {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) => ProductScreen(product: product));
  }

  final Product product;
  const ProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppBar(
        title: product.name,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(67, 65, 61, 1),
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
              BlocBuilder<WishListBloc, WishlistState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: Text('Added to your Wishlist!',style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
                        duration: Duration(seconds: 1),
                        action: SnackBarAction(
                          label: 'Wishlist',
                          textColor: Colors.orange,

                          onPressed: () {
                            Navigator.pushNamed(context, '/wishlist');
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      context.read<WishListBloc>().add(
                        AddProductToWishList(product),
                      );
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              ElevatedButton(

                onPressed: () async {
                  final loginController = Get.find<LoginController>();

                  bool isLoggedIn = await loginController.isLoggedIn();

                  if (isLoggedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(receiverId: 2),
                      ),
                    );

                  } else {

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You need to sign in to use this feature', style: GoogleFonts.aBeeZee(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                        action: SnackBarAction(
                          label: 'Sign In',
                          textColor: Colors.orange,
                          onPressed: () {
                            Navigator.pushNamed(context, '/auth');
                          },
                        ),
                      ),
                    );
                  }
                },
                child: Text('Message',style: GoogleFonts.aBeeZee(textStyle:TextStyle(color: Colors.black),)),

               style: ElevatedButton.styleFrom(
                 primary: Colors.white, // Change to your desired color
               ) ),


            ],
          ),
        ),
      ),
      body: ListView(
        children: [
      CarouselSlider(
      options: CarouselOptions(
      aspectRatio: 1.5,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        viewportFraction: 1,
      ),
      items: [
        Image_slider(
          product: product,
        ),
      ],
    ),

    Padding(
    padding: EdgeInsets.only(left: 10.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [


    // Product price
    reuseText(product.description.toString(),),

    // Product description

    ],
    ),

    ),SizedBox(height: 20,),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0),
      child: Container(


      height: MediaQuery.of(context).size.height *0.4,
      decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
      color: Colors.grey[300]!,
      width: 1.0,
      ),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
      'Details',
      style: GoogleFonts.aBeeZee(textStyle:TextStyle(fontSize: 25))
      ),
      SizedBox(height: 20.0),
      Text(
      'Product Name: ${product.name}',
      style: GoogleFonts.aBeeZee(),
      ),
      SizedBox(height: 20.0),
      Text(
      'Price: \RS. ${product.price}',
      style: GoogleFonts.aBeeZee(textStyle: TextStyle(overflow: TextOverflow.ellipsis)),
        maxLines: 1,
      ),
      SizedBox(height: 20.0),
      Text(
      'Seller: Prashant',
      style: GoogleFonts.aBeeZee(),
      ),
      SizedBox(height: 20.0),
      Text(
      'Condition: Brand New',
      style:GoogleFonts.aBeeZee(),
      ),
      SizedBox(height: 20.0),
      Text(
      'Category:  ${product.category}',
      style:GoogleFonts.aBeeZee(),
      ),
      ],
      ),
      ),
    ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(


              height: MediaQuery.of(context).size.height *0.4,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1.0,
                ),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Product Specification',
                      style: GoogleFonts.aBeeZee(textStyle:TextStyle(fontSize: 25))
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Purchased : 2 years ago',
                    style: GoogleFonts.aBeeZee(),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Brand: Puma',
                    style: GoogleFonts.aBeeZee(textStyle: TextStyle(overflow: TextOverflow.ellipsis)),
                    maxLines: 1,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Size : XXL',
                    style: GoogleFonts.aBeeZee(),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Damages: N/A',
                    style:GoogleFonts.aBeeZee(),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Quantity:  1Pcs',
                    style:GoogleFonts.aBeeZee(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
        Container(child:StreamBuilder<QuerySnapshot>(
            stream: _carouselRef.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot> documentList = snapshot.data!.docs;
                return ImageCarousel(snapshotList: documentList);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          ),
          SizedBox(height: 20.0),
    ],
        )
      );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50.0);
}
reuseText(String title){
  return Text(title,style: GoogleFonts.abel(textStyle:TextStyle(fontSize: 18)
  ),
   );
}
headText(String title){
  return Text(title,style: GoogleFonts.aBeeZee(textStyle:TextStyle(fontSize: 22,fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis)//,
  ),
    maxLines: 1,);
}
sized(){
  return SizedBox(height: 9,);
}

final CollectionReference _carouselRef =
FirebaseFirestore.instance.collection('banner');





