import 'package:flutter/cupertino.dart';
import 'package:takeeazy_customer/model/takeeazyapis/options/optionsmodel.dart';

class OptionController with ChangeNotifier{
  final ValueNotifier updatedController = ValueNotifier(false);

  List<OptionsModel> _list;
  List<OptionsModel> get list => _list;
  set list(List<OptionsModel> list){
    if(list!=_list){
      _list = list;
      notifyListeners();
    }
  }

}