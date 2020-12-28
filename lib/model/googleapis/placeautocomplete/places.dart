class Predictions{
  final List<Places> predictions;
  Predictions(this.predictions);

  factory Predictions.fromJSON(Map<String, dynamic> data){
    List<Places> tmp = [];
    (data['predictions'] as List).forEach((e) {
      tmp.add(Places(main: e['structured_formatting']['main_text'], secondary: e['structured_formatting']['secondary_text'], id: e['place_id']));
    });
    return Predictions(tmp);
  }
}

class Places{
  final String main;
  final String secondary;
  final String id;

  Places({this.main, this.secondary, this.id});

}