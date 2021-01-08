class ContainerModel {
  final String containerName;
  final String description;
  final String id;
  final String imagePath;
  final String updatedAt;

  ContainerModel({this.containerName, this.description, this.id, this.imagePath, this.updatedAt});

  factory ContainerModel.fromJSON(Map<String, dynamic> map) {
    return ContainerModel(
        containerName: map['containerName'],
        description: map['description'],
        id: map['_id'],
        imagePath: map['imagePath'],
        updatedAt: map['updatedAt']);
  }
}

