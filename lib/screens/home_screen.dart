import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_like_app_rest/utils/app_routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 200,
            ),
            Material(
              child: TextField(),
            ),
            Material(
              child: TextField(),
            ),
            ElevatedButton(
              onPressed: () => {},
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.SIGNUP_SCREEN),
              child: Text('Cadastrar'),
            )
          ],
        ),
      ),
    );
  }
}
