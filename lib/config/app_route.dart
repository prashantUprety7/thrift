import 'package:flutter/material.dart';
import 'package:thriftly/model/category_model.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:thriftly/screens/FAQ/faq.dart';
import 'package:thriftly/screens/authentication/auth.dart';
import 'package:thriftly/screens/catalog/catalog.dart';
import 'package:thriftly/screens/category_type.dart';
import 'package:thriftly/screens/dontation.dart';

import 'package:thriftly/screens/product/product.dart';
import 'package:thriftly/screens/screen.dart';
import 'package:thriftly/screens/search/searchscreen.dart';
import 'package:thriftly/screens/whislist/whislist.dart';

import '../screens/homescreen/home_screen.dart';
import '../screens/message.dart';
import '../screens/newproduct/newproduct.dart';
import '../screens/user/user.dart';
import 'package:thriftly/type/type_.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This is route ${settings.name}');
    switch (settings.name) {
      case '/':
        return MyHomeScreen.route();
      case MyHomeScreen.routeName:
        return MyHomeScreen.route();
      case UserScreen.routeName:
        return UserScreen.route();
      case AuthScreen.routeName:
        return AuthScreen.route();
     //case SignUpScreen.routeName:
       // return SignUpScreen.route();

      case FAQPage.routeName:
        return FAQPage.route();
      case DonationScreen.routeName:
        return DonationScreen.route();
      case MessageScreen.routeName:
        return MessageScreen.route();
      case AddProductScreen.routeName:
        return AddProductScreen.route();

      case SearchScreen.routeName:
        return SearchScreen.route();
      case TypeScreen.routeName:
        return TypeScreen.route(type :settings.arguments as ItemType );

      case CatalogScreen.routeName:
        final args = settings.arguments as Map<String, dynamic>;
        final category = args['category'] ;
        final type = args['type'] ;
        return CatalogScreen.route(category: category, type: type);

      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case WhislistScreen.routeName:
        return WhislistScreen.route();
      default:
        return _errRoute();
    }
  }

  static Route<dynamic> _errRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Page not found')),
      ),
    );
  }
}





//debuggin ko lagi