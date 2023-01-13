import 'package:flutter/material.dart';

enum DialogsAction { yes, cancel }

class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.cancel),
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                child: Text(
                  'Confirmar',
                  style: TextStyle(
                      color: Color(0xFFC41A3B), fontWeight: FontWeight.w700),
                ),
              )
            ],
          );
        },);
        return (action != null) ? action : DialogsAction.cancel;
  }
}