import 'package:flutter/material.dart';
import 'package:shop_like_app_rest/models/advert.dart';
import 'package:shop_like_app_rest/repository/adverts_api.dart';
import 'package:shop_like_app_rest/repository/local_storage_hive.dart';
import 'package:shop_like_app_rest/utils/dialogs.dart';

class AdvertFormScreen extends StatefulWidget {
  final Advert advert;

  AdvertFormScreen({this.advert});

  @override
  _AdvertFormScreenState createState() => _AdvertFormScreenState();
}

class _AdvertFormScreenState extends State<AdvertFormScreen> {
  final _advertForm = GlobalKey<FormState>();
  Advert _advert = Advert();
  bool isEditing = false;

  Future<void> _createAdvert() async {
    bool isValid = _advertForm.currentState.validate();
    if(!isValid){
      return;
    }
    _advertForm.currentState.save();
    try{
      Dialogs.showLoadingDialog(context);
      final token = await LocalStorageHive().getToken();
      await AdvertApi.createAdvert(_advert);
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

  Future<void> _editAdvert() async {
    bool isValid = _advertForm.currentState.validate();
    if(!isValid){
      return;
    }
    _advertForm.currentState.save();
    _advert.id = widget.advert.id;
    try{
      Dialogs.showLoadingDialog(context);
      final token = await LocalStorageHive().getToken();
      await AdvertApi.editAdvert(_advert);
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showSuccessDialog(context, 'O anúncio foi editado com sucesso!');
    }on Exception catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showErrorDialog(context, e.toString());
    } catch (e){
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showErrorDialog(context, e.toString());
    }
  }

  @override
  void initState() {
    if(widget.advert != null){
      isEditing = true;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(isEditing ? 'Editar Anúncio' :'Adicionar Anúncio'),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child:  Form(
          key: _advertForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: isEditing ? widget.advert.title : null,
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
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: isEditing ? widget.advert.description : null,
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
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: isEditing ? widget.advert.price.toString() : null,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    primary: Theme.of(context).accentColor
                  ),
                  onPressed: () => isEditing ? _editAdvert() : _createAdvert(),
                  child: Text(isEditing ? 'Editar' : 'Cadastrar', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
