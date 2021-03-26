import 'package:flutter/material.dart';
import 'package:shop_like_app_rest/screens/advert_form_screen.dart';
import 'package:shop_like_app_rest/screens/home_screen.dart';
import 'package:shop_like_app_rest/screens/login_screen.dart';
import 'package:shop_like_app_rest/screens/signup_screen.dart';
import 'package:shop_like_app_rest/screens/splash_screen.dart';
import 'package:shop_like_app_rest/utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anúncios',
      theme: ThemeData(
        primaryColor: Color(0xff1c2845),
        accentColor: Color(0xff10c3e9),
          textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white)),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xff1c2845),
          labelStyle: TextStyle(
              color: Colors.white,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(10)
            ),
          ),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(10)
              ),
              borderSide: BorderSide(color: Color(0xff384363))
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(10)
              ),
              borderSide: BorderSide(color: Color(0xff384363))
          ),
        )
      ),
      routes: {
        AppRoutes.SPLASH_SCREEN: (ctx) => MySplashScreen(),
        AppRoutes.LOGIN_SCREEN: (ctx) => LoginScreen(),
        AppRoutes.SIGNUP_SCREEN: (ctx) => SignupScreen(),
        AppRoutes.HOME_SCREEN: (ctx) => HomeScreen(),
        AppRoutes.ADVERT_FORM_SCREEN: (ctx) => AdvertFormScreen()
      },
    );
  }
}




