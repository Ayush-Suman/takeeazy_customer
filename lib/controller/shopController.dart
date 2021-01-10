import 'package:flutter/material.dart';

class ShopController {}

class ShopDetails {
  final String imageUrl;
  final String shopName;
  final double rating;
  final double distance;
  final String locality;
  final double duration;

  ShopDetails(
      {this.imageUrl = "assets/pickupanddrop.png",
      this.shopName = "Meerut Mall",
      this.rating = 3.8,
      this.distance = 3,
      this.locality = "Gandhi Nagar",
      this.duration = 40});
}

class ShopDetailsController with ChangeNotifier {
  ShopDetails _shopDetails;

  set setShopDetails(ShopDetails shopDetails) {
    _shopDetails = shopDetails;
    notifyListeners();
  }

  ShopDetails get shopDetails => _shopDetails;
}

class CategoriesController with ChangeNotifier {
  List<String> _categories;

  set setCategories(List<String> categories) {
    _categories = categories;
    notifyListeners();
  }

  List<String> get categories => _categories;
}
