import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/exception.dart';
import 'package:takeeazy_customer/model/base/httpworker.dart';
import 'package:takeeazy_customer/model/base/tokenhandler.dart' as TokenHandler;


Function _modifyToken = (token)=> token;

void setTokenModifier({Function tokenModifier}){
  _modifyToken = tokenModifier;
}

get _token => _modifyToken(TokenHandler.token);


void initialise({Function tokenModifier}){
  _modifyToken = tokenModifier;
  init();
}


final List<int> idQueue = [];

final Random _random = Random();
Future<int> _idGenerator() async{
  int rand = _random.nextInt(16);
  if(idQueue.length==16){
    throw Exception("Request Queue Full");
  }
  while(idQueue.contains(rand)){
    rand = _random.nextInt(16);
  }
  idQueue.add(rand);
  return rand;
}

class TEResponse<T>{
  TEResponse(this._id);
  final int _id;

  dispose(){
    sendRequest(_id);
  }

  Completer<T> _response = Completer();
  get response => _response.future;

}

Future<TEResponse<T>> request<T>(String route, {
  @required CALLTYPE call,
  Map<String, String> param,
  Map<String, dynamic> header,
  Map<String, dynamic> body,
  bool auth=false,
  bool isGoogleApi=false,
  http.Client client,
}) async {
  String token = auth?_token: "";

  int id = await _idGenerator();
  print(id);
  TEResponse<T> response = TEResponse(id);

  Map<String, dynamic> data = {
    'id':id,
    'route':route,
    'call':call,
    'param':param,
    'header':header,
    'body':body,
    'auth':auth,
    'token': token,
    'selector': isGoogleApi
  };
  await isReady;
  sendRequest<T>(data).then((value){
    idQueue.remove(id);
    if(value is ResponseException){
      throw value;
    }
    response._response.complete(value);
  });
  return response;
}



void authenticate(String token){
  TokenHandler.saveToken(token);
}

void unauthenticate(){
  TokenHandler.deleteToken();
}


