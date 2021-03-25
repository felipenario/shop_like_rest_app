import 'package:flutter/material.dart';
import 'package:shop_like_app_rest/models/advert.dart';
import 'package:shop_like_app_rest/repository/adverts_api.dart';
import 'package:shop_like_app_rest/repository/local_storage_hive.dart';
import 'package:shop_like_app_rest/utils/dialogs.dart';

class AdvertFormScreen extends StatefulWidget {
  @override
  _AdvertFormScreenState createState() => _AdvertFormScreenState();
}

class _AdvertFormScreenState extends State<AdvertFormScreen> {
  final _advertForm = GlobalKey<FormState>();
  Advert _advert = Advert();

  Future<void> _createAdvert() async {
    bool isValid = _advertForm.currentState.validate();
    if(!isValid){
      return;
    }
    _advertForm.currentState.save();
    try{
      Dialogs.showLoadingDialog(context);
      final token = await LocalStorageHive().getToken();
      await AdvertApi.createAdvert(_advert, token);
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showSuccessDialog(context, 'O anúncio foi criado com sucesso!');
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
      appBar: AppBar(
        title: Text('Adicionar Anúncio'),
      ),
      body: Container(
        child:  Form(
          key: _advertForm,
          child: Column(
            children: [
              Material(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Título'
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value){
                    bool isEmpty = value.trim().isEmpty;
                    if(isEmpty){
                      return 'Digite um título';
                    }
                    return null;
                  },
                  onSaved: (value){
                    setState(() {
                      _advert.title = value;
                    });
                  },
                ),
              ),
              Material(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Descrição'
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value){
                    bool isEmpty = value.trim().isEmpty;
                    if(isEmpty){
                      return 'Digite uma descrição';
                    }
                    return null;
                  },
                  onSaved: (value){
                    setState(() {
                      _advert.description = value;
                    });
                  },
                ),
              ),
              Material(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Preço'
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value){
                    bool isEmpty = value.trim().isEmpty;
                    if(isEmpty){
                      return 'Digite um preço';
                    }
                    return null;
                  },
                  onSaved: (value){
                    setState(() {
                      _advert.price = int.parse(value);
                    });
                  },
                ),
              ),
              TextButton(
                onPressed: () => _createAdvert(),
                child: Text('Cadastrar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
