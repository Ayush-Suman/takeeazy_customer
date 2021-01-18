
import 'package:takeeazy_customer/model/takeeazyapis/options/optionsmodel.dart';

class ContainerModel extends OptionsModel {
  final String description;
  final String id;
  final String updatedAt;

  ContainerModel({containerName, this.description, this.id, imagePath, this.updatedAt}):super(name: containerName, imageURL: imagePath );

  factory ContainerModel.fromJSON(Map<String, dynamic> map) {
    return ContainerModel(
        containerName: map['containerName'],
        description: map['description'],
        id: map['_id'],
        imagePath: map['imagePath'],
        updatedAt: map['updatedAt']);
  }
}

