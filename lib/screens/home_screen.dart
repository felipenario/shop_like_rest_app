import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_like_app_rest/models/advert.dart';
import 'package:shop_like_app_rest/repository/adverts_api.dart';
import 'package:shop_like_app_rest/utils/app_routes.dart';
import 'package:shop_like_app_rest/utils/dialogs.dart';
import 'package:shop_like_app_rest/widgets/advert_card.dart';
import 'package:shop_like_app_rest/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List<Advert>> _advertsFuture;

  void _refreshScreen(){
    setState(() {
      _advertsFuture = _fetchAdverts();
    });
  }

  Future<List<Advert>> _fetchAdverts() async{
    var adverts = await AdvertApi.getAdverts();
    return adverts;
  }

  Future<void> _deleteAdvert(Advert advert) async {
    var adverts = await _advertsFuture;
    try{
      Dialogs.showLoadingDialog(context);
      var index = adverts.indexWhere((advertFromList) => advertFromList.id == advert.id);
      if(index == -1){
        throw ('O index do item não foi encontrado na lista local!');
      }
      setState(() {
        adverts.removeAt(index);
      });
      await AdvertApi.deleteAdvert(advert.id);
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showSuccessDialog(context, 'Anúncio deletado com sucesso!');
    }on Exception catch (e) {
      var index = adverts.indexWhere((advertFromList) => advertFromList.id == advert.id);
      setState(() {
        adverts.insert(index, advert);
      });
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showErrorDialog(context, e.toString());
    } catch (e){
      Navigator.of(context, rootNavigator: true).pop();
      Dialogs.showErrorDialog(context, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _advertsFuture = _fetchAdverts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Anúncios'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () => Navigator.pushNamed(context, AppRoutes.ADVERT_FORM_SCREEN)),
        ],
      ),
      drawer: CustomDrawer(),
      body: Container(
          color: Theme.of(context).primaryColor,
          child: RefreshIndicator(
            onRefresh: () {
              setState(() {
                _advertsFuture = _fetchAdverts();
              });
              return _advertsFuture;
            },
            child: FutureBuilder(
                future: _advertsFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.error != null){
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index){
                          Advert advert = snapshot.data[index];
                          return AdvertCard(advert: advert, onDelete: _deleteAdvert, refreshOnEdit: _refreshScreen);
                        }
                    );
                  }
                  return Container(
                    child: Center(
                      child: Text('Nenhum anúncio cadastrado'),
                    ),
                  );
                }
            ),
          ),
        ),
      );
  }
}
