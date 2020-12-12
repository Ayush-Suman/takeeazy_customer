import 'package:geolocator/geolocator.dart';


// Currently of no practical use
// Will use if necessity felt in future
class LocationHandler{

  Future<Position> getLocation() async{
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}