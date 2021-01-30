import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TEDropDown<E> extends StatelessWidget{
  final ValueNotifier<E> valueController;
  final List items;
  final Function onChanged;

  TEDropDown({this.valueController, this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: valueController,
      builder: (_, a)=>
          Consumer<ValueNotifier<E>>(
              builder: (_, a, c)=>
                  DropdownButton<E>(value: valueController.value, items: items , onChanged: onChanged )
          ),);
  }

}