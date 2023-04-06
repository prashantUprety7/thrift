import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';





class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const CustomAppBar(  {Key? key, required this.title,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/wishlist');
            },
            icon: Icon(Icons.favorite,color: Colors.black,),
          ),

        ],
        title: Text(
          title,
          style: GoogleFonts.aBeeZee(textStyle: TextStyle(
            color: Colors.black,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            fontSize: 30,
          ), )

        ),
        elevation: 2,
        shape: RoundedRectangleBorder(

        ),
        titleSpacing: 20.0,
      ),

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0);
}
