import 'package:takeeazy_customer/model/takeeazyapis/stores/storesModel.dart';

class CartModel {
  final String id;
  final String name;
  final int quantity;
  final String imageURL;
  final String shopName;

  CartModel({
    this.id,
    this.name,
    this.imageURL,
    this.quantity,
    this.shopName,
  });
}
