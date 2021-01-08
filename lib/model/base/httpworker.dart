import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'package:takeeazy_customer/model/base/caching.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/modelclassselector.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/googleapis/base/googleapiconstructor.dart';
import 'package:takeeazy_customer/model/takeeazyapis/base/modelconstructor.dart';


final RequestDataHandler _requestDataHandler = RequestDataHandler();

final ReceivePort _receivePort = ReceivePort();
SendPort _sendPort;
Isolate _isolate;

Completer<void> _isolateReady = Completer<void>();
Future<void> get isReady => _isolateReady.future;


List<Map<String, dynamic>> responseQueue = List<Map<String, dynamic>>();

Future init() async {
  _isolate = await Isolate.spawn(_entryFunction, _receivePort.sendPort);
  _sendPort = await _receivePort.first;
  await initialiseCaching();
  _isolateReady.complete();
}


void destroy() {
  _receivePort.close();
  _isolate.kill();
  _isolate = null;
}


Future<dynamic> sendRequest(var data, {TEResponse response}) async {
  ReceivePort _responsePort = ReceivePort();
  ReceivePort _cachedResponsePort = ReceivePort();
  if(data is Map) {
    int id = data['id'];
  }
  _sendPort.send([
    data,
    _responsePort.sendPort,
    _cachedResponsePort.sendPort]);
  _cachedResponsePort.first.then((value) {
    response.cachedResponseCompleter.complete(value);
    _cachedResponsePort.close();
  });
  dynamic returnValue = await _responsePort.first;
  _responsePort.close();
  print("Hello");
  print(returnValue);
  print("World");
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

  _requestDataHandler.addListener(() async {
    SendPort childSendPort;
    SendPort cachedChildSendPort;
    print("child received");
    int id = _requestDataHandler.newId;
    childSendPort = _requestDataHandler._sendPorts[id];
    cachedChildSendPort = _requestDataHandler._cachedSendPorts[id];
    var data = _requestDataHandler._datas.singleWhere((
        element) => element['id'] == id);
    CALLTYPE call;
    IOClient client = _requestDataHandler._clients[id];
    bool auth;
    ModelClassSelector modelClassSelector;
    Map<String, String> header;
    Map<String, String> param;
    Map<String, dynamic> body;
    String route;
    bool needCachedData;

    if (data is Map<String, dynamic>) {
      call = data['call'];
      auth = data['auth'];
      header = data['header'];
      param = data['param'];
      body = data['body'];
      route = data['route'];
      modelClassSelector =
      data['selector'] as bool ? googleClassSelector : classSelector;
      needCachedData = data['isCached'];
    }
    if(needCachedData??false){
      getCachedData(apiToLocal[route])
          .then((value){
            dynamic modelClass;
            if(value!=null){
                dynamic decoded = jsonDecode(value);
                  if(decoded is List){
                    modelClass = List();
                    for(dynamic m in decoded){
                      modelClass.add(modelClassSelector.classSelector(route, m));
                    }
                  } else {
                    print("Deserialize");
                    modelClass = modelClassSelector.classSelector(route, decoded);
                  }
            }
            cachedChildSendPort.send(modelClass);
      });
    }else{
     cachedChildSendPort.send(null);
    }

    final Uri uri = Uri.https(modelClassSelector.URL, route, param);
    print(uri);
    Map<String, String> headerData = Map.from(
        {HttpHeaders.contentTypeHeader: 'application/json'});
    if (auth) {
      headerData.addAll(
          Map.from({HttpHeaders.authorizationHeader: data['token']}));
    }
    if (header != null) {
      headerData.addAll(header);
    }
    print(headerData.runtimeType);
    print("waiting for response");

/*
    String response="";
    Request request = Request(callTypeMap[call], uri);
    print("Sending Response");
    if(!_requestDataHandler._isCancelled[id]){
    IOStreamedResponse streamedResponse = await client.send(request);
    StreamSubscription streamSubscription  = streamedResponse.stream.transform(utf8.decoder).listen((event) {
      //print("A"+event);
      response+=event;
    });
    // streamSubscription.cancel();
    _requestDataHandler.addSubs(id, streamSubscription);

    streamSubscription.onError((e){
      childSendPort.send(e);
      _requestDataHandler.removeData(id);
      _requestDataHandler._isCancelled.remove(id);
    });

    streamSubscription.onDone(() {
      print(response);
      if(!_requestDataHandler._isCancelled[id]){
        dynamic modelClass;
        dynamic decoded = jsonDecode(response);
        try {
          if (decoded is List) {
            modelClass = List();
            for (dynamic m in decoded) {
              modelClass.add(modelClassSelector.classSelector(route, m));
            }
          } else {
            print("Deserialize");
            modelClass = modelClassSelector.classSelector(route, decoded);
          }
          childSendPort.send(modelClass);
          print("sent " + modelClass.toString());
        } catch (e) {
          print("Error: " + e.toString());
          childSendPort.send(e);
        } finally {
          _requestDataHandler.removeData(id);
        }
      }
      _requestDataHandler._isCancelled.remove(id);
    });
    }

 */


    switch (call) {
      case CALLTYPE.GET:
        client.get(uri, headers: headerData).then((response) {
          print(response.body);
          if(!_requestDataHandler._isCancelled[id]){
          dynamic modelClass;
          dynamic decoded = jsonDecode(response.body);
          print(decoded.toString());
          try {
            if (decoded is List) {
              print("Decoded is list");
              modelClass = List();
              for (dynamic m in decoded) {
                modelClass.add(modelClassSelector.classSelector(route, m));
              }
            } else {
              print("Deserialize");
              modelClass = modelClassSelector.classSelector(route, decoded);
            }
            childSendPort.send(modelClass);
            print("sent " + modelClass.toString());
          } catch (e) {
            print("Error: " + e.toString());
            childSendPort.send(e);
          } finally {
            _requestDataHandler.removeData(id);
          }
        }
        _requestDataHandler._isCancelled.remove(id);
        });
        break;

      case CALLTYPE.POST:
        client.post(uri, headers: headerData, body: body).then((response) {
          print(response.body);
          if(!_requestDataHandler._isCancelled[id]){
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
            cacheData(response.body, apiToLocal[route]);
            childSendPort.send(modelClass);
            print("sent "+modelClass.toString());
          }catch(e){
            print("Error: " +e.toString());
            childSendPort.send(e);
          }finally{
            _requestDataHandler.removeData(id);
          }

        }
          _requestDataHandler._isCancelled.remove(id);
        });
        break;

      case CALLTYPE.DEL:
        client.delete(uri, headers: headerData).then((response) {
          print(response.body);
          if(!_requestDataHandler._isCancelled[id]){
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
            print("sent "+modelClass.toString());
          }catch(e){
            print("Error: " +e.toString());
            childSendPort.send(e);
          }finally{
            _requestDataHandler.removeData(id);
          }
          _requestDataHandler._isCancelled.remove(id);
        }});
        break;
    }
  });


  receivePort.listen((message) {
    if(message[0] is Map){
      _requestDataHandler.addData(message);
    } else {
      print(message);
      _requestDataHandler.removeData(message[0]);
    }
  });
}



class RequestDataHandler with ChangeNotifier{
  Map<int, SendPort> _sendPorts = {};
  Map<int, SendPort> _cachedSendPorts = {};
  Map<int,IOClient> _clients = {};
  Map<int, bool> _isCancelled = {};

  List<Map> _datas = [];
  int newId;
 /*
  void addSubs(int id, StreamSubscription streamSubscription){
    _subsList.addAll({id: streamSubscription});
  }
*/

  void addData(List data){
    var reqdata = data[0];
    newId = reqdata['id'];
    _sendPorts.addAll({newId: data[1]});
    _cachedSendPorts.addAll({newId: data[2]});
    _isCancelled.addAll({newId: false});
    _clients.addAll({newId:IOClient()});
    _datas.add(reqdata);
    notifyListeners();
  }

  void removeData(int id){
    /*
    if(_subsList[id]!=null){
      _subsList[id].cancel()
          .whenComplete(() {
        print("Cancelling");
        _subsList.remove(id);
          });
    }
     */
    if(_clients[id]!=null) {
      _clients[id].close();
      _clients.remove(id);
    }
   if(_sendPorts[id]!=null){
     _cachedSendPorts[id].send(null);
     _cachedSendPorts.remove(id);
     _sendPorts[id].send(null);
     _sendPorts.remove(id);
   }
    _isCancelled[id] = true;
     _datas.removeWhere((element) => element['id']==id);

  }
}

Map<CALLTYPE, String> callTypeMap={
  CALLTYPE.GET: "GET",
  CALLTYPE.POST: "POST",
  CALLTYPE.DEL: "DELETE"
};



