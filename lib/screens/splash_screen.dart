import 'package:flutter/material.dart';
import 'package:shop_like_app_rest/repository/local_storage_hive.dart';
import 'package:shop_like_app_rest/screens/home_screen.dart';
import 'package:shop_like_app_rest/screens/login_screen.dart';

class MySplashScreen extends StatelessWidget {

  Future<String> _getToken() async{
    return LocalStorageHive().getToken();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getToken(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if(snapshot.error != null){
            return LoginScreen();
          }
          if(snapshot.hasData){
            return HomeScreen();
          }
          return LoginScreen();
        },
    );
  }
}
