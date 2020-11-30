import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:takeeazy_customer/model/base/modelconstructor.dart';
import 'tokenhandler.dart';

// Uses Token Handler functions

String _URL = "https://takeeazy-backend.herokuapp.com";

enum CALLTYPE{
  GET,
  POST

}

Isolate isolate;

void networkCallInit() async{
  isolate = await Isolate.spawn((message) { }, "");
}

void networkCallDestroy() async{
  isolate.kill();
}

dynamic jsonToModel(Map<String, dynamic> jsonAndFunc){
  dynamic decoded = jsonDecode(jsonAndFunc['json'] as String);
  dynamic data;
  if(decoded is List){
    data = List();
    for(dynamic m in decoded){
      data.add(createClass(jsonAndFunc['route'] as String, m));
    }
  } else {
    data = createClass(jsonAndFunc['route'] as String, decoded);
  }
  return data;
}


Future<T> request<T>(String route, {
  @required CALLTYPE call,
  Map<String, String> param,
  Map<String, dynamic> header,
  Map<String, dynamic> body,
  bool auth=true,
  http.Client client,
}) async {

  Map<String, dynamic> headerData = {HttpHeaders.contentTypeHeader: 'application/json'};

  if(auth){
    headerData.addAll({HttpHeaders.authorizationHeader: await token});
  }

  http.Response response;
  final Uri uri = Uri.http(_URL,route, param);

  // Network CALL based on CALL TYPE
  switch(call) {
    case CALLTYPE.GET:
      response = await (client == null ?
      http.get(uri, headers: headerData..addAll(header)) :
      client.get(uri, headers: headerData..addAll(header)));
      break;

    case CALLTYPE.POST:
      response = await (client == null ?
      http.post(uri, headers: headerData..addAll(header), body: body) :
      client.post(uri, headers: headerData..addAll(header), body: body));
      break;
  }


  Map<String, dynamic> jsonAndFunc = {
    'json': response.body,
    'route':  route,
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

