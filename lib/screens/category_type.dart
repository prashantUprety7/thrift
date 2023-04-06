import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thriftly/blocs/product/product_bloc.dart';
import 'package:thriftly/main.dart';
import 'package:thriftly/model/category_model.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:thriftly/widgets/Custom_Appbar.dart';
import 'package:thriftly/widgets/product_cards.dart';

import '../../widgets/Custom_bottombar.dart';
import '../blocs/category/category_bloc.dart';
import '../widgets/slider_home.dart';
import 'catalog/catalog.dart';
import 'package:thriftly/type/type_.dart';

class TypeScreen extends StatelessWidget with PreferredSizeWidget {
  static const String routeName = '/typescreen';

  static Route route({required ItemType type}) {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => TypeScreen(
      type: type,
    ));
  }
  final ItemType type;
  const TypeScreen({required this.type});
  @override
  Widget build(BuildContext context) {
    String title = '';
    switch (type) {
      case ItemType.shoes:
        title = 'Shoes';
        break;
      case ItemType.clothes:
        title = 'Clothes';
        break;

    }

   // final type = ModalRoute.of(context)!.settings.arguments as Type;
    return Scaffold(
      appBar: CustomAppBar(
         title: title,

      ),
      body: Container(
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return CircularProgressIndicator();
            } else if (state is CategoryLoaded) {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        CatalogScreen.routeName,
                        arguments: {
                          'category': category,
                          'type': type,
                        },
                      );
                    },
                    child:  Slider_carousel(
                      category: category,
                      type: type,
                    ),
                  );
                },
              );
            } else {
              return Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}
