import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:takeeazy_customer/model/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/modelconstructor.dart';
import 'package:takeeazy_customer/model/base/tokenhandler.dart';


String _URL = "takeeazy-backend.herokuapp.com";

ReceivePort _receivePort = ReceivePort();
SendPort _sendPort;
Isolate _isolate;

Completer<void> _isolateReady = Completer<void>();
Future<void> get isReady => _isolateReady.future;

List<Map<String, dynamic>> responseQueue = List<Map<String, dynamic>>();

void init() async {
  _isolate = await Isolate.spawn(_entryFunction, _receivePort.sendPort);
  _receivePort.listen((message) {
    if(message is SendPort){
      _sendPort = message;
      _isolateReady.complete();
    }else{
      print('adding'+message['id']);
      responseQueue.add(message);
    }
  });

}

void destroy() {
  _isolate.kill();
}


Future<T> sendRequest<T>(var data) async {
  print('sending id: ' + data['id'].toString());
  _sendPort.send(data);
  for(;;){
    var response = responseQueue.where((element) => element['id']==data['id']).toList();
    if(response.length > 0){
      responseQueue.remove(response);
      return response[0]['model'] as T;
    }
  }
}



void _entryFunction(SendPort sendPort) async{
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  print('sendPort sent from network isolate');
  receivePort.listen((data) async{
    print('received request for id: '+ data['id'].toString());
    CALLTYPE call;
    Client client;
    bool auth;
    Map<String, dynamic> header;
    Map<String, String> param;
    Map<String, dynamic> body;
    String route;

    if(data is Map<String, dynamic>){
      call = data['call'];
      client = data['client'];
      auth = data['auth'];
      header = data['header'];
      param = data['param'];
      body = data['body'];
      route = data['route'];
    }

    final Uri uri = Uri.https(_URL,route, param);
    print('uri parsed');
    Map<String, dynamic> headerData = {HttpHeaders.contentTypeHeader: 'application/json'} as Map<String, dynamic>;
    if(auth){
      headerData.addAll({HttpHeaders.authorizationHeader: await token});
    }
    if(header!=null) {
      headerData.addAll(header);
    }
    print(headerData.runtimeType);
    Response response;
    print('making call');
    switch(call) {
      case CALLTYPE.GET:
        response = await (client == null ?
        get(uri, headers: headerData):
        client.get(uri, headers: headerData));
        break;

      case CALLTYPE.POST:
        response = await (client == null ?
        post(uri, headers: headerData, body: body) :
        client.post(uri, headers: headerData, body: body));
        break;
    }
    print('fetched response from ' + route);
    print(response.body);
    dynamic modelClass;
    dynamic decoded = jsonDecode(response.body);
    if(decoded is List){
      modelClass = List();
      for(dynamic m in decoded){
        modelClass.add(createClass(route, m));
      }
    } else {
      modelClass = createClass(route, decoded);
    }
    Map<String, dynamic> returnMap = {'model': modelClass, 'id': data['id']};
    print('returning');
    sendPort.send(returnMap);
    print('return sent');
  });

}

