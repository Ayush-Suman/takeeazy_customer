class SearchItemModel {
  final List<String> imagePaths;
  final bool isAgeRestricted;
  final String id;
  final String itemId;
  final String retailerId;
  final List<Variants> variants;
  final String createdAt;
  final String updatedAt;
  final int v;

  SearchItemModel(
      {this.imagePaths,
      this.isAgeRestricted,
      this.id,
      this.itemId,
      this.retailerId,
      this.variants,
      this.createdAt,
      this.updatedAt,
      this.v});

  factory SearchItemModel.fromJSON(Map<String, dynamic> map) {
    return SearchItemModel(
      imagePaths: map['imagePaths'],
      isAgeRestricted: map['isAgeRestricted'],
      id: map['_id'],
      itemId: map['itemId'],
      retailerId: map['retailerId'],
      variants: map['variants'].map((e) => Variants.fromJSON(e)).toList(),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      v: map['__v'],
    );
  }
}

class Variants {
  final String variantId;
  final String variantName;
  final double mrp;
  final double sellingPrice;
  final int quantity;

  Variants(
      {this.variantId,
      this.variantName,
      this.mrp,
      this.sellingPrice,
      this.quantity});

  factory Variants.fromJSON(Map<String, dynamic> data) {
    return Variants(
        variantId: data['variantId'],
        variantName: data['variantName'],
        mrp: data['mrp'],
        sellingPrice: data['sellingPrice'],
        quantity: data['quantity']);
  }
}
