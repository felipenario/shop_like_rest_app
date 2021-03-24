import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {

  final String title;
  final String content;
  final bool isLoadingType;

  CustomDialog({
    this.title,
    this.content,
    this.isLoadingType,
  });
  CustomDialog.success({
    this.title = 'Operação concluída com sucesso!',
    this.content,
    this.isLoadingType = false
  });
  CustomDialog.error({
    this.title = 'Ocorreu um erro!',
    this.content,
    this.isLoadingType = false
  });

  CustomDialog.loading({
    this.title,
    this.content,
    this.isLoadingType = true
  });

  @override
  Widget build(BuildContext context) {
    if(isLoadingType){
      return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          children: [
            Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Carregando')
                ],
              ),
            )
          ],
        ),
      );
    }else{
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Fechar'))
        ],
      );
    }
  }
}
