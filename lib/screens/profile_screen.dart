import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shop_like_app_rest/models/user.dart';
import 'package:shop_like_app_rest/repository/adverts_api.dart';
import 'package:shop_like_app_rest/repository/local_storage_hive.dart';
import 'package:shop_like_app_rest/utils/app_routes.dart';
import 'package:shop_like_app_rest/utils/dialogs.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  final Function() refreshUser;


  ProfileScreen({this.user, this.refreshUser});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileForm = GlobalKey<FormState>();

  final MaskTextInputFormatter _phoneMask = MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });

  User _user = User();

  Future<void> _editUser() async {
    bool isValid = _profileForm.currentState.validate();
    if(!isValid){
      return;
    }
    _profileForm.currentState.save();
    try {
      Dialogs.showLoadingDialog(context);
      await AdvertApi.editUser(_user);
      widget.refreshUser();
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showSuccessDialog(context, 'Usuário editado com sucesso!');
    } on Exception catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showErrorDialog(context, e.toString());
    } catch (e){
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showErrorDialog(context, e.toString());
    }
  }

  Future<void> _deleteUser() async {
    final bool delete = await Dialogs.showConfirmDeleteUserDialog(context);
    if(!delete){
       return;
    }
    try {
      Dialogs.showLoadingDialog(context);
      await AdvertApi.deleteUser(widget.user);
      await LocalStorageHive().deleteToken();
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushReplacementNamed(context, AppRoutes.LOGIN_SCREEN);
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
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){
              _deleteUser();
          },
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Form(
          key: _profileForm,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                  radius: 40,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: widget.user.name,
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
                      _user.name = value;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: _phoneMask.maskText(widget.user.phone),
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
                      _user.phone = _phoneMask.unmaskText(value);
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
                      _user.password = value;
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
                  onPressed: () => _editUser(),
                  child: Text('Editar usuário', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
