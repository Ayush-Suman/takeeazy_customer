import 'dart:math';

import 'package:takeeazy_customer/model/base/URLRoutes.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:takeeazy_customer/model/base/httpworker.dart';
import 'tokenhandler.dart';


List<int> _ids = List();
Random _random = Random();
void networkInit(){
  init();
}

Future<T> request<T>(String route, {
  @required CALLTYPE call,
  Map<String, String> param,
  Map<String, dynamic> header,
  Map<String, dynamic> body,
  bool auth=true,
  http.Client client,
}) async {

  print('request function called');
  int rand = _random.nextInt(256);
  while(_ids.contains(rand)){
    rand = _random.nextInt(256);
  }
  _ids.add(rand);

  print('request id: '+rand.toString());

  Map<String, dynamic> data = {
    'route':route,
    'call':call,
    'param':param,
    'header':header,
    'body':body,
    'auth':auth,
    'client':client,
    'id': rand
  };
  print('data map built');
  await isReady;
  print('isolate ready');
  dynamic response = await sendRequest(data);
  _ids.remove(rand);
  return response as T;
}


void authenticate(String token){
  saveToken(token);
}

void unauthenticate(){
  deleteToken();
}

