import 'dart:async';

import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';

enum NavBarItem { HOME, ALERT, SETTINGS }

class NavigationBloc implements BlocBase {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.HOME;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.HOME);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.ALERT);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.SETTINGS);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }

  dispose() {
    close();
  }
}
