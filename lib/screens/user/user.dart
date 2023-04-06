
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thriftly/screens/authentication/auth.dart';

import '../../controller/logincontroller.dart';
import '../../controller/userinfocontroller.dart';
import '../../widgets/Custom_Appbar.dart';

class UserScreen extends StatefulWidget {



  static const String routeName = '/user';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => UserScreen(),
    );
  }

  @override
  State<StatefulWidget> createState() => _UserState();
}

class _UserState extends State<UserScreen> {

  final userController = Get.put(UserScreenController());





  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  'https://www.w3schools.com/w3images/avatar2.png'),
            ),
            SizedBox(height: 10),
            FutureBuilder<Map<String, dynamic>>(
              future: userController.getUserInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final user = snapshot.data!;
                  return Column(
                    children: [
                      Text('Welcome ${user['name'] as String? ?? 'Unknown'}',style: GoogleFonts.aBeeZee(),),
                      Text('Email: ${user['email'] as String? ?? 'Unknown'}',style: GoogleFonts.aBeeZee(),),

                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),






            // SizedBox(height: 10),

            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('My Wishlist',style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20)) ,),
              onTap: () {
                Navigator.pushNamed(context,'/wishlist');
                // navigate to wishlist screen
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Order History',style:  GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20)),),
              onTap: () {

                // navigate to order history screen
              },
            ),
            ListTile(
              leading: Icon(Icons.support_agent),
              title: Text('Support' ,style:GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20))),
              onTap: () {
                // navigate to wallet screen
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings',style:  GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20)),),
              onTap: () {
                // navigate to settings screen
              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                final loginController = Get.find<LoginController>();
                await loginController.logout();
                Navigator.pushNamed(context, '/');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(67, 65, 61, 1),
                  fixedSize: const Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Icon(Icons.logout),
                Text('Logout',style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20)),)
              ],
             ),
            ),
          ],
        ),
      ),
    );
  }

}