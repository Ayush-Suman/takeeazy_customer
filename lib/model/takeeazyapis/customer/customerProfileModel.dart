class CustomerProfileModel {
  final Cart cart;
  final List<String> savedPaymentMethod;
  final List<String> favStore;
  final List<String> favItem;
  final String id;
  final int phone;
  final String createdAt;
  final String updatedAt;
  final int v;

  CustomerProfileModel(
      {this.cart,
      this.savedPaymentMethod,
      this.favStore,
      this.favItem,
      this.id,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.v});

  factory CustomerProfileModel.fromJSON(Map<String, dynamic> map) {
    return CustomerProfileModel(
        cart: Cart.fromJSON(map['cart']),
        savedPaymentMethod: map['savedPaymentMethod'],
        favStore: map['favStore'],
        favItem: map['favItem'],
        id: map['_id'],
        phone: map['phone'],
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt'],
        v: map['__v']);
  }
}

class Cart {
  final List<String> items;

  Cart({this.items});

  factory Cart.fromJSON(Map<String, dynamic> map) {
    return Cart(items: map['items']);
  }
}
