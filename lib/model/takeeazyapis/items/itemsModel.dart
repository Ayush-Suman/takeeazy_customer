import 'package:takeeazy_customer/model/takeeazyapis/options/optionsmodel.dart';

class ItemsModel extends OptionsModel{
  final String description;
  final List<String> labels;
  final String id;
  final String categoryId;
  final String subCategory;
  final String createdAt;
  final String updatedAt;
  final String categoryName;
  final String containerId;
  final int v;
  final List<Variants> variants;

  ItemsModel(
      {this.description,
      String imagePath,
      this.labels,
      this.id,
      String itemName,
      this.categoryId,
      this.subCategory,
      this.createdAt,
      this.updatedAt,
      this.categoryName,
      this.containerId,
      this.v,
      this.variants}):super(imageURL: imagePath, name: itemName);

  factory ItemsModel.fromJSON(Map<String, dynamic> map) {
    return ItemsModel(
      description: map['description'],
      imagePath: map['imagePath'],
      labels: map['labels'],
      id: map['id'],
      itemName: map['itemName'],
      categoryId: map['categoryId'],
      subCategory: map['subCategory'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      categoryName: map['categoryName'],
      containerId: map['containerId'],
      v: map['__v'],
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
