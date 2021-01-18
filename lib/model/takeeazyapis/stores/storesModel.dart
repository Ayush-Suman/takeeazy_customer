class ShopModel{
  String id;
  String shopName;
  int primaryPhone;
  String createdAt;
  List<Category> categories;
  Location location;

  ShopModel({this.id, this.shopName, this.primaryPhone, this.createdAt, this.categories, this.location});

  factory ShopModel.fromJSON(Map<String, dynamic> shopData) {
    return ShopModel(id : shopData['_id'],
    shopName: shopData['storeName'],
    primaryPhone : shopData['primaryPhone'],
    createdAt : shopData['createdAt'],
    categories : shopData['categories'].map((e)=> Category.fromJSON(e)).toList().cast<Category>(),
    location : Location.fromJSON(shopData['location'])
    );
  }

}

class Category {
  final bool hasSubcategories;
  final List<String> subCategories;
  final String categoryId;

  Category({this.hasSubcategories, this.subCategories, this.categoryId});

  factory Category.fromJSON(Map data)=> Category(subCategories: data['hasSubcategories'], categoryId: data['categoryId']);

}

class Location {
  final String type;
  final List<double> coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJSON(Map<String, dynamic> location){
    return Location(type: location['type'], coordinates: location['coordinates'].cast<double>());
  }
}