import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_like_app_rest/models/advert.dart';
import 'package:shop_like_app_rest/screens/advert_form_screen.dart';
import 'package:shop_like_app_rest/utils/app_routes.dart';
import 'package:shop_like_app_rest/utils/dialogs.dart';
import 'package:shop_like_app_rest/widgets/dismissible_delete.dart';
import 'package:shop_like_app_rest/widgets/dismissible_edit.dart';

class AdvertCard extends StatelessWidget {

  final Advert advert;
  final Function(Advert) onDelete;
  final Function() refreshAdverts;

  AdvertCard({this.advert, this.onDelete, this.refreshAdverts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Dismissible(
        key: Key(advert.id.toString()),
        background: DismissibleEdit(),
        secondaryBackground: DismissibleDelete(),
        confirmDismiss: (direction) async {
          if(direction == DismissDirection.startToEnd){
            Navigator.push(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: AppRoutes.ADVERT_FORM_SCREEN),
                  builder: (ctx) => AdvertFormScreen(advert: advert),
                )
            ).then((_) => {
              refreshAdverts()
            });
            return false;
          }else{
            final bool delete = await Dialogs.showConfirmDeleteAdvertDialog(context);
            if(delete){
              onDelete(advert);
            }
            return delete;
          }
        },
        child: Material(
          elevation: 5,
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff384363),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)
                      )
                  ),
                  height: 80,
                  child: Center(
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        child: Icon(Icons.chat_bubble_sharp, color: Colors.white),
                      ),
                      title: Text(advert.title, style: TextStyle(color: Colors.white)),
                      subtitle: Text(advert.description, style: TextStyle(color: Color(0xff384363)),),
                      trailing: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                        ),
                        child: Center(child: Text('R\$${advert.price.toString()}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 0.5,
                  color: Color(0xff384363),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(advert.user.name, style: TextStyle(color: Colors.white)),
                          Text('${DateFormat('dd/MM/yyy').format(advert.createdAt)} às ${DateFormat('hh:mm').format(advert.createdAt)}', style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
