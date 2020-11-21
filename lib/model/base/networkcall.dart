import 'package:http/http.dart' as http;
import 'tokenhandler.dart';

// Uses Token Handler functions

String _URL = "https://takeeazy-backend.herokuapp.com";

Future<http.Response> GET(String Route, {bool auth=true}) {
  String Token = '';
  if(!auth){
    Token = token;
  }
  return http.get(_URL+ Route, headers: {"Authorization": Token});
}

Future<http.Response> POST(String Route, {dynamic body, bool auth=true}) {
  String Token = '';
  if(!auth){
    Token = token;
  }
  return http.post(_URL+ Route, headers: {"Authorization": Token}, body: body);
}

void authenticate(String Token){
  saveToken(Token);
}

void unauthenticate(){
  deleteToken();
}

