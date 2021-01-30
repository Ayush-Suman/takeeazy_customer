import 'package:takeeazy_customer/model/takeeazyapis/items/itemsModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/options/optionsmodel.dart';


class CartModel extends OptionsModel{
  final int quantity;
  final String imageURL;
  final String shopName;
  final List<Variants> variants;
  Variants selectedVariant;

  CartModel({
    String id,
    String name,
    this.imageURL,
    this.quantity,
    this.shopName,
    this.variants,
    this.selectedVariant
  }):super(id: id, name: name);
}
