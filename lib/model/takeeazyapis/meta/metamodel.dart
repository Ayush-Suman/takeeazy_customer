import 'package:flutter/material.dart';

class MetaModel{
  final City city;
  final List<Containers> containers;

  MetaModel({
      this.city,
      this.containers
  });

  factory MetaModel.fromJSON(Map<String, dynamic> map){
    print("Metamodel");
    return MetaModel(
      city: City.fromJSON(map['city']),
      containers: map['containers'].map((e)=>Containers.fromJSON(e)).toList().cast<Containers>()
    );
  }
}

class City{
  final String id;
  final String cityName;
  final List<String> containers;

  City({this.id, this.cityName, this.containers});

  factory City.fromJSON(Map<String, dynamic> data){
    print("Metamodel city");
    return City(id: data['_id'], cityName: data['cityName'], containers: data['containers'].cast<String>());
  }
}


class Containers{
  final String id;
  final String updatedAt;

  Containers({this.id, this.updatedAt});


  factory Containers.fromJSON(Map<String, dynamic> data){
    return Containers(id: data['_id'], updatedAt: data['updatedAt']);
  }
}