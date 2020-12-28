import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/modelclassselector.dart';
import 'package:takeeazy_customer/model/googleapis/base/googleapiconstructor.dart';
import 'package:takeeazy_customer/model/takeeazyapis/base/modelconstructor.dart';


final RequestDataHandler _requestDataHandler = RequestDataHandler();

final ReceivePort _receivePort = ReceivePort();
SendPort _sendPort;
Isolate _isolate;

Completer<void> _isolateReady = Completer<void>();
Future<void> get isReady => _isolateReady.future;


List<Map<String, dynamic>> responseQueue = List<Map<String, dynamic>>();

void init() async {
  _isolate = await Isolate.spawn(_entryFunction, _receivePort.sendPort);
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
  if(data is Map) {
    int id = data['id'];
  }
    _sendPort.send([
      data, _responsePort.sendPort]);
    T returnValue = await _responsePort.first;
    _responsePort.close();
    return returnValue;
}

void _entryFunction(var meta) async{

  // As a best practice,
  // these classes should be provided from the main isolate
  // to remove dependency of this function from the dynamics
  // of the class selectors
  final GoogleClassSelector googleClassSelector = GoogleClassSelector();
  final ClassSelector classSelector = ClassSelector();
  print("entry function started");

  ReceivePort receivePort = ReceivePort();
  meta.send(receivePort.sendPort);
  SendPort childSendPort;

  _requestDataHandler.addListener(() async{
    print("child received");
    int id = _requestDataHandler.newId;
    childSendPort = _requestDataHandler._sendPorts[id];
    var data = _requestDataHandler._datas.singleWhere((element) => element['id']==id);
    CALLTYPE call;
    Client client = _requestDataHandler._clients[id];
    bool auth;
    ModelClassSelector modelClassSelector;
    Map<String, String> header;
    Map<String, String> param;
    Map<String, dynamic> body;
    String route;

    if(data is Map<String, dynamic>){
      call = data['call'];
      auth = data['auth'];
      header = data['header'];
      param = data['param'];
      body = data['body'];
      route = data['route'];
      modelClassSelector = data['selector'] as bool? googleClassSelector : classSelector;
    }

    final Uri uri = Uri.https(modelClassSelector.URL,route, param);
    Map<String, String> headerData = Map.from({HttpHeaders.contentTypeHeader: 'application/json'});
    if(auth){
      headerData.addAll(Map.from({HttpHeaders.authorizationHeader: data['token']}));
    }
    if(header!=null) {
      headerData.addAll(header);
    }
    print(headerData.runtimeType);
    Response response;
    print("waiting for response");
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

      case CALLTYPE.DEL:
        response = await (client==null?
        delete(uri, headers: headerData) :
        client.delete(uri, headers: headerData)
        );
        break;
    }
    print(response.body);
    dynamic modelClass;
    dynamic decoded = jsonDecode(response.body);
    try{
      if(decoded is List){
        modelClass = List();
        for(dynamic m in decoded){
          modelClass.add(modelClassSelector.classSelector(route, m));
        }
      } else {
        print("Deserialize");
        modelClass = modelClassSelector.classSelector(route, decoded);
      }
      childSendPort.send(modelClass);
    }catch(e){
      print(e);
      childSendPort.send(e);
    }finally{
      _requestDataHandler.removeData(id);
    }
  });


  await for(var message in receivePort){
    if(message[0] is Map){
      _requestDataHandler.addData(message);
    } else {
      print(message);
      _requestDataHandler.removeData(message[0]);
    }
  }


}



class RequestDataHandler with ChangeNotifier{
  Map<int, SendPort> _sendPorts = {};
  Map<int,Client> _clients = {};
  List<Map> _datas = [];
  int newId;
  void addData(List data){
    var reqdata = data[0];
    newId = reqdata['id'];
    _sendPorts.addAll({newId: data[1]});
    _clients.addAll({newId:Client()});
    _datas.add(reqdata);
    notifyListeners();
  }

  void removeData(int id){
    if(_clients[id]!=null) {
      _clients[id].close();
      _clients.remove(id);
    }
    _sendPorts[id].send(null);
    _sendPorts.remove(id);
    _datas.removeWhere((element) => element['id']==id);

  }
}
