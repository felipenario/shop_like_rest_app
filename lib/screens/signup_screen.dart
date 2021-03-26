import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shop_like_app_rest/models/user.dart';
import 'package:shop_like_app_rest/repository/adverts_api.dart';
import 'package:shop_like_app_rest/utils/dialogs.dart';

class SignupScreen extends StatefulWidget {

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupForm = GlobalKey<FormState>();
  final MaskTextInputFormatter _phoneMask = MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });

  String _name = '';

  String _phone = '';

  String _password = '';

  Future<void> _signup() async {
    bool isValid = _signupForm.currentState.validate();
    if(!isValid){
      return;
    }
    _signupForm.currentState.save();
    try {
      Dialogs.showLoadingDialog(context);
      await AdvertApi.signup(
          User(
            name: _name,
            phone: _phoneMask.getUnmaskedText(),
            password: _password,
          )
      );
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showSuccessDialog(context, 'Usuário criado com sucesso!');
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
        elevation: 0,
        centerTitle: true,
        title: Text('Fazer cadastro'),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Form(
          key: _signupForm,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
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
              Container(
                margin: const EdgeInsets.all(10),
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
                margin: const EdgeInsets.all(10),
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
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                      primary: Theme.of(context).accentColor
                  ),
                  onPressed: () => _signup(),
                  child: Text('Cadastrar', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
