import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/auth_service/auth_wrapper.dart';
import '../../widgets/inputfield_auth.dart';
import '../../widgets/submitbutton.dart';
import 'package:thriftly/controller/signupcontroller.dart';
import 'package:thriftly/controller/logincontroller.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const String routeName = '/auth';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => AuthScreen(),
    );
  }
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  RegistrationController registerationController =
  Get.put(RegistrationController());

  LoginController loginController = Get.put(LoginController());

  var isLogin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Center(
            child: Obx(
                  () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Text(
                      'WELCOME',
                      style:GoogleFonts.aBeeZee(textStyle:TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w400), )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      MaterialButton(
                        color: isLogin.value ? Color.fromRGBO(67, 65, 61, 1) : Colors.white,
                        onPressed: () {
                          isLogin.value = true;
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              color: isLogin.value ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      MaterialButton(
                        color: !isLogin.value ? Color.fromRGBO(67, 65, 61, 1) : Colors.white,
                        onPressed: () {
                          isLogin.value = false;
                        },
                        child: Text(
                          'Register',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              color: !isLogin.value ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  isLogin.value ? loginWidget() : registerWidget(),
                  SizedBox(height: 60),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('Assets/image/logo.png'),

                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text(
                              'Follow Us On Social Media',
                              style:GoogleFonts.aBeeZee(textStyle:TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ), )
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // handle social media button pressed
                                  },
                                  icon: Icon(Icons.facebook),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // handle social media button pressed
                                  },
                                  icon:  Icon(FontAwesomeIcons.twitter),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // handle social media button pressed
                                  },
                                  icon:  Icon(FontAwesomeIcons.instagram),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerWidget() {
    return Column(
      children: [
        InputTextFieldWidget(registerationController.namecontroller, 'Name',false),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.emailcontroller, 'Email address',false),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.passwordcontroller, 'Password',true),
        SizedBox(
          height: 50,
        ),
        SubmitButton(
          onPressed: () => registerationController.registerWithEmail(context),
          title: 'Register',
        )
      ],
    );
  }

  Widget loginWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.emailcontroller, 'Email address',false),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.passwordcontroller, 'Password',true),
        SizedBox(
          height: 50,
        ),
        SubmitButton(
          onPressed: () => loginController.loginWithEmail(context),
          title: 'Login',
        )
      ],
    );
  }

  }


