import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'tokenhandler.dart';

// Uses Token Handler functions

String _URL = "https://takeeazy-backend.herokuapp.com";

enum CALLTYPE{
  GET,
  POST

}



dynamic jsonToModel(Map<String, dynamic> jsonAndFunc){
  dynamic decoded = jsonDecode(jsonAndFunc['json'] as String);
  dynamic data;
  Function function = jsonAndFunc['func'] as Function;
  if(decoded is List){
    data = List();
    for(dynamic m in decoded){
      data.add(function(m));
    }
  } else {
    data = function(decoded);
  }
  return data;
}


Future<T> request<T>(String route, {
  CALLTYPE call,
  Map<String, dynamic> param,
  Map<String, dynamic> header,
  Map<String, dynamic> body,
  bool auth=true,
  http.Client client,
  Function fromJSON
}) async {

  Map<String, dynamic> headerData = Map();

  if(auth){
    headerData.addAll({"Authorization": await token});
  }

  http.Response response;

  // Network CALL based on CALL TYPE
  switch(call) {
    case CALLTYPE.GET:
      response = await (client == null ?
      http.get(_URL + route, headers: headerData..addAll(header)) :
      client.get(_URL + route, headers: headerData..addAll(header)));
      break;

    case CALLTYPE.POST:
      response = await (client == null ?
      http.post(_URL + route, headers: headerData..addAll(header), body: body) :
      client.post(_URL + route, headers: headerData..addAll(header), body: body));
      break;
  }


  Map<String, dynamic> jsonAndFunc = {
    'json': response.body,
    'func': fromJSON
  };
  // Converts JSON to DAO
  return compute(jsonToModel, jsonAndFunc) as T;

}


void authenticate(String token){
  saveToken(token);
}

void unauthenticate(){
  deleteToken();
}

