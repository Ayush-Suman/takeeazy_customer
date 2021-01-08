import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
Directory _directory;
String _path;

Future initialiseCaching()async{
  _directory =  await getApplicationSupportDirectory();
  _path = _directory.path;
}

Future cacheData(String data, String name) async{
  File file = File("$_path/$name.txt");
  await file.writeAsString(data);
}

Future<String> getCachedData(String name){
  File file = File("$_path/$name.txt");
  return file.readAsString();
}

// Will be replaced by SQL
Future storeData(dynamic data, String name) async{
  File file = File("$_path/$name.txt");
  String json = jsonEncode(data);
  file.writeAsString(json);
}

Future<dynamic> readData(String name) async{
  File file = File("$_path/$name.txt");
   String data = await file.readAsString();
   return jsonDecode(data);
}

Map<String, String> apiToLocal = {
  URLRoutes.getMeta:"Meta"
};

