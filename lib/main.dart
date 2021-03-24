import 'package:flutter/material.dart';
import 'package:shop_like_app_rest/screens/home_screen.dart';
import 'package:shop_like_app_rest/screens/signup_screen.dart';
import 'package:shop_like_app_rest/utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Like',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        AppRoutes.HOME_SCREEN: (ctx) => HomeScreen(),
        AppRoutes.SIGNUP_SCREEN: (ctx) => SignupScreen()
      },
    );
  }
}




