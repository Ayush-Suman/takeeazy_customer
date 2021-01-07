class ContainerModel {
  final String description;
  final String id;
  final String imagePath;
  final String updatedAt;

  ContainerModel({this.description, this.id, this.imagePath, this.updatedAt});

  factory ContainerModel.fromJSON(Map<String, dynamic> map) {
    return ContainerModel(
        description: map['description'],
        id: map['_id'],
        imagePath: map['imagePath'],
        updatedAt: map['updatedAt']);
  }
}
