import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:http/http.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/modelconstructor.dart';


String _URL = "takeeazy-backend.herokuapp.com";

ReceivePort _receivePort = ReceivePort();
SendPort _sendPort;
Isolate _isolate;

Completer<void> _isolateReady = Completer<void>();
Future<void> get isReady => _isolateReady.future;

List<Map<String, dynamic>> responseQueue = List<Map<String, dynamic>>();

void init(ClassSelector modelClassSelector) async {
  _isolate = await Isolate.spawn(_entryFunction, [_receivePort.sendPort, modelClassSelector]);
  _sendPort = await _receivePort.first;
  _isolateReady.complete();
}

void destroy() {
  _receivePort.close();
  _isolate.kill();
  _isolate = null;
}


Future<T> sendRequest<T>(var data) async {
  ReceivePort _responsePort = ReceivePort();
  _sendPort.send([data, _responsePort.sendPort]);
  T returnValue = await _responsePort.first;
  _responsePort.close();
  return returnValue;
}

void _entryFunction(var meta) async{
  ReceivePort receivePort = ReceivePort();
  meta[0].send(receivePort.sendPort);
  ClassSelector modelClassSelector = meta[1];
  SendPort childSendPort;
  await for(var message in receivePort){
    childSendPort = message[1];
    var data = message[0];
    CALLTYPE call;
    Client client;
    bool auth;
    Map<String, String> header;
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
    Map<String, String> headerData = Map.from({HttpHeaders.contentTypeHeader: 'application/json'});
    if(auth){
      headerData.addAll(Map.from({HttpHeaders.authorizationHeader: data['token']}));
    }
    if(header!=null) {
      headerData.addAll(header);
    }
    print(headerData.runtimeType);
    Response response;
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
    print(response.body);
    dynamic modelClass;
    dynamic decoded = jsonDecode(response.body);
    if(decoded is List){
      modelClass = List();
      for(dynamic m in decoded){
        modelClass.add(modelClassSelector.classSelector(route, m));
      }
    } else {
      modelClass = modelClassSelector.classSelector(route, decoded);
    }
    childSendPort.send(modelClass);
  }

}

