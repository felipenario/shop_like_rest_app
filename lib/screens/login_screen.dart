import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shop_like_app_rest/models/user.dart';
import 'package:shop_like_app_rest/repository/adverts_api.dart';
import 'package:shop_like_app_rest/repository/local_storage_hive.dart';
import 'package:shop_like_app_rest/utils/app_routes.dart';
import 'package:shop_like_app_rest/utils/dialogs.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final MaskTextInputFormatter _phoneMask = MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });
  final _loginForm = GlobalKey<FormState>();

  String _phone = '';
  String _password = '';

  Future<void> _login() async {
    bool isValid = _loginForm.currentState.validate();
    if(!isValid){
      return;
    }
    _loginForm.currentState.save();
    try{
      Dialogs.showLoadingDialog(context);
      var token = await AdvertApi.login(
        User(
          phone: _phoneMask.getUnmaskedText(),
          password: _password
        )
      );
      await LocalStorageHive().saveToken(token);
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushReplacementNamed(context, AppRoutes.HOME_SCREEN);
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
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Form(
          key: _loginForm,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(
                  size: 200,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Telefone'
                    ),
                    inputFormatters: [_phoneMask],
                    keyboardType: TextInputType.phone,
                    validator: (value){
                      bool isEmpty = value.trim().isEmpty;
                      if(isEmpty){
                        return 'Digite um telefone';
                      }
                      return null;
                    },
                    onSaved: (value){
                      setState(() {
                        _phone = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Senha'
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value){
                      bool isEmpty = value.trim().isEmpty;
                      if(isEmpty){
                        return 'Digite uma senha';
                      }
                      return null;
                    },
                    onSaved: (value){
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        primary: Theme.of(context).accentColor
                    ),
                    onPressed: () => _login(),
                    child: Text('Login'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.SIGNUP_SCREEN),
                  child: Text('Cadastrar', style: TextStyle(fontWeight: FontWeight.w700)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
