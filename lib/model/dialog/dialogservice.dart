import 'dart:async';

import 'package:flutter/widgets.dart';

class DialogService {
  DialogService._instance();
  static DialogService _getDialogService;

  factory DialogService(){
    if(_getDialogService==null){
      _getDialogService = DialogService._instance();
    }
    return _getDialogService;
  }

  Function _showDialog;
  Completer _completer;

  void registerDialogListener(Function f){
    _showDialog = f;
  }

  Future openDialog<T>({String title, String content, List<ActionHolder> actions}) async{
    _completer = Completer<T>();
    _showDialog<T>(title: title, content: content, actions: actions);
    return _completer.future as Future<T>;
  }

  Future closeDialog<T>(T response){
    _completer.complete(response);
    _completer = null;
    return null;
  }

}

class ActionHolder{
  ActionHolder({@required this.title, @required this.onPressed});
  final String title;
  final Function onPressed;
}