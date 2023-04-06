import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:thriftly/type/type_.dart';
import 'package:thriftly/widgets/banner.dart';
import '../../blocs/product/product_bloc.dart';
import '../../widgets/Custom_bottombar.dart';
import '../../widgets/head_text.dart';
import '../../widgets/product_cards.dart';
import '../../widgets/product_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class  MyHomeScreen extends StatelessWidget with PreferredSizeWidget {
  final CollectionReference _carouselRef =
  FirebaseFirestore.instance.collection('banner');

  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName), builder: (_) => MyHomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar:  AppBar(
        iconTheme:const  IconThemeData(color: Colors.black),
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        actions: [

          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            icon: const Icon(Icons.search,color: Colors.black),
          ),
        ],
        title: Text(
         'THRIFTLY',
          style: GoogleFonts.aBeeZee(textStyle:const TextStyle(

            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 30,
          ),)
        ),
        elevation: 2,
        shape: const RoundedRectangleBorder(

        ),
        titleSpacing: 20.0,
      ),
      drawer: Drawer(

        child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const UserAccountsDrawerHeader(

                  accountName:  Text("Prashant Uprety"),
                  accountEmail: Text("prashantuprety90@gmail.com"),
                  decoration:  BoxDecoration(color: Color.fromRGBO(67,65,61,10),),
                  currentAccountPicture:  CircleAvatar(
                    backgroundImage:  NetworkImage(
                        "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png"),
                  ),
                ),
                Column(
                  children: [



                    ListTile(
                      leading:const Icon(Icons.home),
                      title: const Text("Home"),
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                    ListTile(
                      leading:const Icon(Icons.person),
                      title: const Text("Account"),
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                    ListTile(
                      leading:const Icon(Icons.note_add),
                      title: const Text("Post New Ad "),
                      onTap: () {
                        Navigator.pushNamed(context, '/newproduct');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.remove_red_eye),
                      title: const Text("My ads"),
                      onTap: () {
                        Navigator.pushNamed(context, '/myads');

                      },
                    ),
                    ListTile(
                      leading:const Icon(Icons.comment),
                      title: const Text("Ads Comment"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading:const Icon(Icons.mode_comment_rounded),
                      title: const Text("Messages"),
                      onTap: () {
                        Navigator.pushNamed(context, '/message');

                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.waving_hand_sharp),
                      title: const Text("Donation"),
                      onTap: () {
                        Navigator.pushNamed(context, '/donation');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.help),
                      title: const Text("FAQ",style: TextStyle(letterSpacing: 3),),
                      onTap: () {
                        Navigator.pushNamed(context, '/faq');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      ),

      bottomNavigationBar: const custom_bottom_nav(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 110,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/typescreen',arguments:ItemType.shoes );
                        // Navigate to the category screen for shoes
                      },
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: const AssetImage('Assets/image/category_shoes.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Shoes',
                                style:GoogleFonts.aBeeZee(textStyle:  const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),)
                              ),
                              const   SizedBox(height: 3,),
                              Text('(For all)',   style:GoogleFonts.aBeeZee(textStyle:  const TextStyle(
                              color: Colors.white,
                                fontSize: 17,

                                fontWeight: FontWeight.bold,
                              ),))
                            ],
                          ),


                      ),
                    ),
                  ),
                  const  SizedBox(width: 10,),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/typescreen',arguments:ItemType.clothes);

                        // Navigate to the category screen for clothes
                      },
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image:  AssetImage('Assets/image/category_clothes.jpg'),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                                 Text(
                                  'Clothes',
                                     style:GoogleFonts.aBeeZee(textStyle:  const TextStyle(
                                       color: Colors.white,
                                       fontSize: 30,
                                       fontWeight: FontWeight.bold,
                                     ),)
                                ),
                              const SizedBox(height: 3,),
                               Text('(For all)',   style:GoogleFonts.aBeeZee(textStyle:  const TextStyle(
                                color: Colors.white,
                                fontSize: 17,

                                fontWeight: FontWeight.bold,
                              ),))

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),



            head_text(
              title: 'Recommended',
            ),
            BlocBuilder<ProductBloc, ProductState>(   //not fetching due to api,currently running on test api
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(

                    ),
                  );
                } else if (state is ProductLoaded) {
                  return product_slider(
                    products: state.products
                        .where((product) => product.isRecommended)
                        .toList(),
                  );
                } else {
                  return const Text('Something went wrong');
                }
              },
            ),
            head_text(
              title: 'Most Popular',
            ),
            BlocBuilder<ProductBloc, ProductState>(  //not fetching due to  api,currently running on test api
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                     child: CircularProgressIndicator(

                    ),
                  );
                } else if (state is ProductLoaded) {
                  return product_slider(
                    products: state.products
                        .where((product) => product.isPopular)
                        .toList(),
                  );
                } else {
                  return const Text('Something went wrong');
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Container(child:StreamBuilder<QuerySnapshot>(
              stream: _carouselRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot> documentList = snapshot.data!.docs;
                  return ImageCarousel(snapshotList: documentList);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            ),
            const SizedBox(
              height: 30,
            ),
         Padding(
           padding: const EdgeInsets.only(left: 14.0),
           child: Container(
            alignment: Alignment.centerLeft,
            child:Text.rich(
              TextSpan(
                text: 'Recently ',
                style: GoogleFonts.aBeeZee(textStyle: const TextStyle(fontSize: 23)),
                children: [
                  WidgetSpan(
                    child: Container(
                      margin: const EdgeInsets.only(left: 5.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                      ),

                      child: Text(
                        'added',
                        style: GoogleFonts.aBeeZee(textStyle: const TextStyle(fontSize: 20,color: Colors.red)),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),
         ),


            const SizedBox(
              height: 10,
            ),
            Container(
              child: BlocBuilder<ProductBloc , ProductState>(
                  builder: (context, state) {
                    if(state is ProductLoading){
                      return const CircularProgressIndicator();
                    }if(state is ProductLoaded){
                      final List<Product>allProducts = state.products;


                      return
                        GridView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.6,
                              crossAxisSpacing: 11.0,
                              mainAxisSpacing: 15.0,


                            ),
                            shrinkWrap: true,
                            itemCount: allProducts.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.4,
                                  child: product_card(
                                    products: allProducts[index],

                                  ),
                                );

                            }



                        );
                    } else {
                      return const Text('Something is wrong');
                    }
                  }
              ),
            ),


          ],
        ),

      ),

    );

  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50.0);
}



//slider home page

//slider ends