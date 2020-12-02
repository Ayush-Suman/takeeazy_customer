import 'package:takeeazy_customer/model/base/URLRoutes.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/httpworker.dart';
import 'package:takeeazy_customer/model/base/modelconstructor.dart';
import 'package:takeeazy_customer/model/base/tokenhandler.dart' as TokenHandler;

void networkInit(ClassSelector modelClassSelector){
  init(modelClassSelector);
}

Future<T> request<T>(String route, {
  @required CALLTYPE call,
  Map<String, String> param,
  Map<String, dynamic> header,
  Map<String, dynamic> body,
  bool auth=false,
  http.Client client,
}) async {

  String token = await TokenHandler.token;
  Map<String, dynamic> data = {
    'route':route,
    'call':call,
    'param':param,
    'header':header,
    'body':body,
    'auth':auth,
    'client':client,
    'token': token
  };
  await isReady;
  dynamic response = await sendRequest(data);
  return response as T;
}

void authenticate(String token){
  TokenHandler.saveToken(token);
}

void unauthenticate(){
  TokenHandler.deleteToken();
}

