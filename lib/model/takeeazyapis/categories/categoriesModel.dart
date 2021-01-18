import 'package:takeeazy_customer/model/takeeazyapis/options/optionsmodel.dart';

class CategoriesModel extends OptionsModel {
  final String description;
  final bool hasSubCategories;
  final List<String> subCategories;
  final String id;
  final String containerId;
  final int v;

  CategoriesModel(
      {this.description,
      this.hasSubCategories,
      this.subCategories,
      this.id,
      String categoryName,
      this.containerId,
      this.v,
      String imagePath}): super(name: categoryName, imageURL: imagePath);

  factory CategoriesModel.fromJSON(Map<String, dynamic> map) {
    return CategoriesModel(
        description: map['description'],
        hasSubCategories: map['hasSubCategories'],
        subCategories: map['subCategories'].cast<String>(),
        id: map['_id'],
        categoryName: map['categoryName'],
        containerId: map['containerId'],
        v: map['__v'],
        imagePath: map['imagePath']);
  }
}
