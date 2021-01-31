import 'package:flutter/cupertino.dart';
import 'package:takeeazy_customer/model/takeeazyapis/options/optionsmodel.dart';

class OptionController<E extends OptionsModel> with ChangeNotifier{
  final ValueNotifier<bool> updatedController = ValueNotifier<bool>(false);

  List<E> _list;
  List<E> get list => _list;
  set list(List<E> list){
    if(list!=_list){
      _list = list;
      notifyListeners();
    }
  }

}