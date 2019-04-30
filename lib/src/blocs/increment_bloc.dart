import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';

class IncrementBloc implements BlocBase {
  int _counter;
  final _httpClient = new HttpClient();

  //
  // Stream to handle the counter
  //
  StreamController<int> _counterController = StreamController<int>();
  StreamSink<int> get _inUpdate => _counterController.sink;
  Stream<int> get outCounter => _counterController.stream;

  //
  // Stream to handle the action on the counter
  //
  StreamController<String> _actionController = StreamController<String>();
  StreamSink<String> get updateCounter => _actionController.sink;

  //
  // Constructor
  //
  IncrementBloc() {
    _counter = 0;
    _actionController.stream.listen(_handleLogic);
  }

  void dispose() {
    _actionController.close();
    _counterController.close();
  }

  void _handleLogic(String data) {
    if (data == 'add') {
      _counter = _counter + 1;
    } else {
      if (_counter == 0) {
        _counter = 0;
      } else {
        _counter = _counter - 1;
      }
    }

    _inUpdate.add(_counter);

    testGet();
  }

  ///
  /// GET on test UR
  ///
  Future<String> testGet() async {
    // var uri = Uri.https('api.web-caisse.com', 'pomona/getGuest', <String, String>{
    var uri = Uri.http('api.web-caisse.dev', 'pomona/getGuest', <String, String>{
      'id': '82583',
      'type': 'category',
      'barcode': '0209127006432',
    });

    print('=======>  HTTP : ' + uri.toString());
    String response = await _getRequest(uri);
    if (response != null) print(response);

    return response;
  }

  ///
  /// Routine to invoke the TMDB Web Server to get answers
  ///
  Future<String> _getRequest(Uri uri) async {
    try {
      var request = await _httpClient.getUrl(uri);
      var response = await request.close();
      
      _httpClient.get(host, port, path)

      return response.transform(utf8.decoder).join();
    } catch (e) {
      print(e.toString());

      return null;
    }
  }
}
