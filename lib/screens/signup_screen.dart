import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_like_app_rest/models/user.dart';
import 'package:shop_like_app_rest/repository/adverts_api.dart';
import 'package:shop_like_app_rest/utils/dialogs.dart';

class SignupScreen extends StatefulWidget {

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _form = GlobalKey<FormState>();

  String _name = '';

  String _phone = '';

  String _password = '';

  Future<void> _submitForm() async {
    bool isValid = _form.currentState.validate();
    if(!isValid){
      return;
    }
    try {
      Dialogs.showLoadingDialog(context);
      final _advertApi = AdvertApi();
      var signup = await _advertApi.signup(
          User(
            name: _name,
            phone: _phone,
            password: _password,
          )
      );
      Navigator.of(context, rootNavigator: true).pop();
    } on Exception catch (e) {
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
      appBar: AppBar(
        title: Text('Fazer cadastro'),
      ),
      body: Container(
        child: Form(
          key: _form,
          child: Column(
            children: [
              Material(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Nome'
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value){
                    bool isEmpty = value.trim().isEmpty;
                    if(isEmpty){
                      return 'Digite um nome';
                    }
                    return null;
                  },
                  onSaved: (value){
                    setState(() {
                      _name = value;
                    });
                  },
                ),
              ),
              Material(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Telefone'
                  ),
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
              Material(
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
              TextButton(
                onPressed: () => _submitForm(),
                child: Text('Cadastrar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
