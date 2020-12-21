import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeeazy_customer/model/dialog/dialogservice.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';

class DialogManager extends StatefulWidget{
  Widget child;
  DialogManager({Key key, this.child}):super(key: key);
  @override
  State<StatefulWidget> createState() => _DialogManagerState();

}

class _DialogManagerState extends State<DialogManager>{
  final DialogService dialogService = DialogService();

  @override
  void initState() {
    dialogService.registerDialogListener(dialog);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future dialog<T>({String title, String content, List<ActionHolder> actions}) async{
    T response = await showDialog<T>(
      context: context,
      builder: (_)=> AlertDialog(
        title: TEText(text: title, fontSize: 18, fontWeight: FontWeight.w700,),
        content: TEText(text: content),
        actions: actions.map((e) => FlatButton(
            onPressed: () async {
              await e.onPressed();
              Navigator.pop(context);
            }, child: TEText(text: e.title))).toList(),


      )
    );
    dialogService.closeDialog<T>(response);
  }
}