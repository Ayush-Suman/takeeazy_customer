ShopModel shopModel(Map<String, dynamic> map){
  return ShopModel.fromJSON(map);
}


class ShopModel{
  String id;
  String shopName;
  int primaryPhone;
  String createdAt;
  List<String> categories;
  Location location;

  ShopModel({this.id, this.shopName, this.primaryPhone, this.createdAt, this.categories, this.location});

  factory ShopModel.fromJSON(Map<String, dynamic> shopData) {
    return ShopModel(id : shopData['_id'],
    shopName: shopData['shopName'],
    primaryPhone : shopData['primaryPhone'],
    createdAt : shopData['createdAt'],
    categories : shopData['categories'],
    location : Location.fromJSON(shopData['location'])
    );
  }

}

class Location {
  final String type;
  final List<double> coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJSON(Map<String, dynamic> location){
    return Location(type: location['type'], coordinates: location['coordinates']);
  }
}