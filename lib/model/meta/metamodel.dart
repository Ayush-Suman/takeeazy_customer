class MetaModel{
  final City city;
  //final List<Containers> containers;

  MetaModel({
      this.city,
    //  this.containers
  });

  factory MetaModel.fromJSON(Map<String, dynamic> map){
    return MetaModel(
      city: City.fromJSON(map['city']),
      //containers: map['containers']
    );
  }
}

class City{
  final String id;
  final String cityName;
 // final List<Containers> containers;

  City({this.id, this.cityName});

  factory City.fromJSON(Map<String, dynamic> data){
    return City(id: data['_id'], cityName: data['cityName']);
  }
}

class Containers{

}