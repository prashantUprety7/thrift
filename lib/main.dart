import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thriftly/blocs/category/category_bloc.dart';
import 'package:thriftly/blocs/wishlist/wishlist_bloc.dart';
import 'package:thriftly/config/app_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thriftly/product_Api/bloc/product_bloc.dart';
import 'package:thriftly/product_Api/productrepo.dart';
import 'package:thriftly/repositories/category/category_repository.dart';
import 'package:thriftly/repositories/product/product_repository.dart';
import 'package:thriftly/screens/homescreen/home_screen.dart';
import 'blocs/product/product_bloc.dart';
import 'controller/logincontroller.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp();
  Get.put(LoginController());
  runApp(MyApp());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {

  });

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [


        BlocProvider(create: (_) => WishListBloc()..add(LoadWishList())),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(productRepository: ProductRepository())
            ..add(LoadProducts()),
        ),
        BlocProvider(
          create: (_) => ProductBlocApi(productRepositoryapi: ProductRepositoryImpl(baseUrl: 'https://fakestoreapi.com/'))
            ..add(LoadProductsApi()),
        ),
        BlocProvider(create: (_) => CategoryBloc(categoryRepository:CategoryRepository())..add(LoadCategories())),
      ],

      child: MaterialApp(
        title: 'Thriftly',
        debugShowCheckedModeBanner: false,

        onGenerateRoute: AppRouter.onGenerateRoute,

             //default//SplashScreen.routeName,
        home:  MyHomeScreen(),
      ),
    );
  }
}

