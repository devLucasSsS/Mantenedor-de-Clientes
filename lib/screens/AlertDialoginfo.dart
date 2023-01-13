import 'package:flutter/material.dart';

enum DialogsActionInfo { yes, cancel }

class AlertDialogsinfo {
  static Future<DialogsActionInfo> yesCancelDialog(
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
                    Navigator.of(context).pop(DialogsActionInfo.cancel),
                child: Text(
                  'Aceptar',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },);
        return (action != null) ? action : DialogsActionInfo.cancel;
  }
}