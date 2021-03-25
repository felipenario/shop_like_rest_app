import 'package:flutter/material.dart';
import 'package:shop_like_app_rest/repository/adverts_api.dart';
import 'package:shop_like_app_rest/repository/local_storage_hive.dart';
import 'package:shop_like_app_rest/utils/app_routes.dart';

class HomeScreen extends StatelessWidget {

  _getAdverts() async{
    var token = await LocalStorageHive().getToken();
    AdvertApi.getAdverts(token);
  }

  @override
  Widget build(BuildContext context) {
    _getAdverts();
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () => Navigator.pushNamed(context, AppRoutes.ADVERT_FORM_SCREEN))
        ],
      ),
      body: Container(),
    );
  }
}
