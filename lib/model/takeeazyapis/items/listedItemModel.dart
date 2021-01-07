class ListedItemModel {
  final String description;
  final String id;
  final String itemName;
  final String categoryName;
  final List<Variants> variants;

  ListedItemModel(
      {this.description,
      this.id,
      this.itemName,
      this.categoryName,
      this.variants});

  factory ListedItemModel.fromJSON(Map<String, dynamic> map) {
    return ListedItemModel(
      description: map['description'],
      id: map['_id'],
      itemName: map['itemName'],
      categoryName: map['categoryName'],
      variants: map['variants'].map((e) => Variants.fromJSON(e)).toList(),
    );
  }
}

class Variants {
  final String id;
  final String variantName;
  final double MRP;

  Variants({this.id, this.variantName, this.MRP});

  factory Variants.fromJSON(Map<String, dynamic> data) {
    return Variants(
        id: data['_id'], variantName: data['variantName'], MRP: data['MRP']);
  }
}
