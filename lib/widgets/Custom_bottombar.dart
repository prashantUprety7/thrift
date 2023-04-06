import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../controller/logincontroller.dart';

class custom_bottom_nav extends StatelessWidget {
  const custom_bottom_nav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white,

              boxShadow: [
                const BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6,
                    spreadRadius: 5,
                    offset: Offset(0, 2))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                    size: 32,
                  )),
              IconButton(
                  onPressed: () async{

        final loginController = Get.find<LoginController>();

        bool isLoggedIn = await loginController.isLoggedIn();

        if (isLoggedIn) {

          Navigator.pushNamed(context, '/user');
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
                  icon: Icon(Icons.person_outlined, color: Colors.black,size: 32,)),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/wishlist');
                  },
                  icon: Icon(Icons.favorite_border_outlined, color: Colors.black,size: 32,))
            ],
          )),
    );
  }
}


