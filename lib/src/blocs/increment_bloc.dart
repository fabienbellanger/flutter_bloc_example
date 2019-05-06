import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';

class IncrementBloc implements BlocBase {
  final int _counterInitial = 0;
  final HttpClient _httpClient = new HttpClient();

  int counter;

  //
  // Stream to handle the counter
  //
  StreamController<int> _counterController = StreamController<int>.broadcast();
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
    counter = _counterInitial;
    _actionController.stream.listen(_handleLogic);
  }

  void dispose() {
    _actionController.close();
    _counterController.close();
  }

  void _handleLogic(String data) {
    if (data == 'add') {
      counter = counter + 1;
    } else {
      if (counter == 0) {
        counter = 0;
      } else {
        counter = counter - 1;
      }
    }

    _inUpdate.add(counter);

    // testGet();
  }

  ///
  /// GET on test UR
  ///
  Future<String> testGet() async {
    // var uri = Uri.https('api.web-caisse.com', 'pomona/getGuest', <String, String>{
    Uri uri = Uri.http('api.web-caisse.dev', 'pomona/getGuest', <String, String>{
      'id': '825830908878990',
      'type': 'category',
      'barcode': '0209127006432',
    });

    print('=======>  HTTP : ' + uri.toString());
    String response = await _getRequest(uri);

    if (response != null) {
      print('<=======  ' + response);
    }

    return response;
  }

  ///
  /// Routine to invoke the TMDB Web Server to get answers
  ///
  Future<String> _getRequest(Uri uri) async {
    try {
      HttpClientRequest request = await _httpClient.getUrl(uri);
      HttpClientResponse response = await request.close();

      return response.transform(utf8.decoder).join();
    } catch (e) {
      print('<=======  ' + e.toString());

      return null;
    }
  }
}
