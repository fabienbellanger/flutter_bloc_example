import 'dart:async';

import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';

class IncrementBloc implements BlocBase {
  final int _counterInitial = 0;

  int counter;

  ///
  /// Stream to handle the counter
  ///
  StreamController<int> _counterController = StreamController<int>.broadcast();
  StreamSink<int> get _inUpdate => _counterController.sink;
  Stream<int> get outCounter => _counterController.stream;

  ///
  /// Stream to handle the action on the counter
  ///
  StreamController<String> _actionController = StreamController<String>();
  StreamSink<String> get updateCounter => _actionController.sink;

  /// Constructor
  ///
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
  }
}
