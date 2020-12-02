abstract class ModelClassSelector{
  dynamic classSelector(String route, Map<String, dynamic> map);
  // Define classSelector which takes route as first parameter and response value of type map as the second value.
  // This method returns constructed model class based on the first parameter by using the values in the map.
  // As a good practice define route Strings as static const as member variables of class extending this or as top level const String.
}