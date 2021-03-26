import 'package:flutter/material.dart';
import 'package:shop_like_app_rest/repository/adverts_api.dart';
import 'package:shop_like_app_rest/repository/local_storage_hive.dart';
import 'package:shop_like_app_rest/utils/app_routes.dart';
import 'package:shop_like_app_rest/utils/dialogs.dart';

class CustomDrawer extends StatelessWidget {

  Future<void> _logout(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context);
      await AdvertApi.logout();
      await LocalStorageHive().deleteToken();
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushReplacementNamed(context, AppRoutes.LOGIN_SCREEN);
    }on Exception catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showErrorDialog(context, e.toString());
    } catch (e){
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                    radius: 40,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text('Fazer Logout', style: TextStyle(color: Colors.white)),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }
}
