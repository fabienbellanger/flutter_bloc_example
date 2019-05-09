import 'dart:async';

import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/models/Category.dart';

enum NavBarItem { HOME, ALERT }

class NavigationBloc implements BlocBase {
  ///
  /// BottomAppBar
  ///
  final StreamController<NavBarItem> _appBarController = StreamController<NavBarItem>.broadcast();
  Stream<NavBarItem> get itemStream => _appBarController.stream;

  NavBarItem defaultItem = NavBarItem.HOME;

  ///
  /// TabBar
  ///
  List<Category> tabBarItems = new List();

  final StreamController<List<Category>> _setTabBarItemsController = StreamController<List<Category>>.broadcast();
  Stream<List<Category>> get outTabBarItems => _setTabBarItemsController.stream;

  final StreamController<List<Category>> _getTabBarItemsController = StreamController<List<Category>>.broadcast();
  StreamSink get getTabBarItems => _getTabBarItemsController.sink;

  ///
  /// Constructor
  ///
  NavigationBloc() {
    // Get all TabBar items
    tabBarItems
      ..add(new Category('Voiture', 58673, true))
      ..add(new Category('Train', 58677, false))
      ..add(new Category('TGV', 58677, false))
      ..add(new Category('TER', 58677, false))
      ..add(new Category('Oui', 58677, false))
      ..add(new Category('eTGV', 58677, false))
      ..add(new Category('Bike', 58671, false));

    _getTabBarItemsController.stream.listen((_) {
      _setTabBarItemsController.sink.add(tabBarItems);
    });
  }

  /// Item selection
  void selectAppBarItem(int i) {
    switch (i) {
      case 0:
        _appBarController.sink.add(NavBarItem.HOME);
        break;
      case 1:
        _appBarController.sink.add(NavBarItem.ALERT);
        break;
    }
  }

  dispose() {
    _appBarController?.close();
    _setTabBarItemsController?.close();
    _getTabBarItemsController?.close();
  }
}
