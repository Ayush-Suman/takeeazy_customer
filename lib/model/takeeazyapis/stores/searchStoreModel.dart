class SearchStoreModel {
  final String description;
  final List<String> containers;
  final bool isOpen;
  final bool isOperable;
  final bool isFastDelivery;
  final String id;
  final List<String> categories;
  final String username;
  final String salt;
  final String hashed_password;
  final String email;
  final String shopName;
  final String ownerName;
  final int primaryPhone;
  final String cityId;
  final int v;
  final Location location;

  SearchStoreModel(
      {this.description,
      this.containers,
      this.isOpen,
      this.isOperable,
      this.isFastDelivery,
      this.id,
      this.categories,
      this.username,
      this.salt,
      this.hashed_password,
      this.email,
      this.shopName,
      this.ownerName,
      this.primaryPhone,
      this.cityId,
      this.v,
      this.location});

  factory SearchStoreModel.fromJSON(Map<String, dynamic> map) {
    return SearchStoreModel(
        description: map['description'],
        containers: map['containers'],
        isOpen: map['isOpen'],
        isOperable: map['isOperable'],
        isFastDelivery: map['isFastDelivery'],
        id: map['_id'],
        categories: map['categories'],
        username: map['username'],
        salt: map['salt'],
        hashed_password: map['hashed_password'],
        email: map['email'],
        shopName: map['shopName'],
        ownerName: map['ownerName'],
        primaryPhone: map['primaryPhone'],
        location: Location.fromJSON(map['location']),
        cityId: map['cityId'],
        v: map['__v']);
  }
}

class Location {
  final String type;
  final List<double> coordinates;
  final String id;

  Location({this.type, this.coordinates, this.id});

  factory Location.fromJSON(Map<String, dynamic> location) {
    return Location(
        type: location['type'],
        coordinates: location['coordinates'],
        id: location['_id']);
  }
}
