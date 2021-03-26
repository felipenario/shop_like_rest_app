import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {

  final String title;
  final String content;
  final bool isLoadingType;
  final bool isDeletingType;

  CustomDialog({
    this.title,
    this.content,
    this.isLoadingType,
    this.isDeletingType = false,
  });
  CustomDialog.success({
    this.title = 'Operação concluída com sucesso!',
    this.content,
    this.isLoadingType = false,
    this.isDeletingType = false,

  });
  CustomDialog.error({
    this.title = 'Ocorreu um erro!',
    this.content,
    this.isLoadingType = false,
    this.isDeletingType = false,
  });

  CustomDialog.loading({
    this.title,
    this.content,
    this.isLoadingType = true,
    this.isDeletingType = false,
  });

  CustomDialog.confirmDelete({
    this.title = 'Tem certeza que deseja deletar esse anúncio?',
    this.content = 'O anuncio depois de deletado não pode ser restaurado!',
    this.isLoadingType = false,
    this.isDeletingType = true,
  });

  @override
  Widget build(BuildContext context) {
    if(isLoadingType){
      return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          backgroundColor: Theme.of(context).primaryColor,
          children: [
            Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Carregando', style: TextStyle(color: Colors.white),)
                ],
              ),
            )
          ],
        ),
      );
    }else{
      return AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(title),
        content: Text(content),
        actions: isDeletingType ? [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text('Fechar', style: TextStyle(color: Colors.white))),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Deletar', style: TextStyle(color: Colors.white))),
        ] : [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Fechar', style: TextStyle(color: Colors.white))),
        ],
      );
    }
  }
}
