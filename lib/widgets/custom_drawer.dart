import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shop_like_app_rest/models/user.dart';
import 'package:shop_like_app_rest/repository/adverts_api.dart';
import 'package:shop_like_app_rest/repository/local_storage_hive.dart';
import 'package:shop_like_app_rest/screens/profile_screen.dart';
import 'package:shop_like_app_rest/utils/app_routes.dart';
import 'package:shop_like_app_rest/utils/dialogs.dart';

class CustomDrawer extends StatelessWidget {

  final User user;

  final Function() refreshUser;

  final MaskTextInputFormatter _phoneTextFormatter = MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });

  CustomDrawer({this.user, this.refreshUser});

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
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                    radius: 40,
                  ),
                  Text(user.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  Text(_phoneTextFormatter.maskText(user.phone), style: TextStyle(color: Colors.white))
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
              leading: Icon(Icons.person, color: Colors.white),
              title: Text('Gerenciar usuário', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: RouteSettings(name: AppRoutes.PROFILE_SCREEN),
                    builder: (ctx) => ProfileScreen(user: user, refreshUser: refreshUser),
                  )
              ),
            ),
            Divider(
              color: Color(0xff384363),
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
