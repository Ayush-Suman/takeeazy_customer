class CategoriesModel {
  final String description;
  final bool hasSubCategories;
  final List<String> subCategories;
  final String id;
  final String categoryName;
  final String containerId;
  final int v;
  final String imagePath;

  CategoriesModel(
      {this.description,
      this.hasSubCategories,
      this.subCategories,
      this.id,
      this.categoryName,
      this.containerId,
      this.v,
      this.imagePath});

  factory CategoriesModel.fromJSON(Map<String, dynamic> map) {
    return CategoriesModel(
        description: map['description'],
        hasSubCategories: map['hasSubCategories'],
        subCategories: map['subCategories'].cast<String>(),
        id: map['_id'],
        categoryName: map['categoryName'],
        containerId: map['containerId'],
        v: map['__v'],
        imagePath: map['imagePaths']);
  }
}
