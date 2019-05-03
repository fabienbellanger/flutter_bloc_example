import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/navigation_bloc.dart';

///
/// BottomNavigationBar class
///
class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

///
/// BottomNavBar state class
///
class _BottomNavBarState extends State<BottomNavBar> {
  NavigationBloc _navigationBloc;

  @override
  void initState() {
    super.initState();
    _navigationBloc = NavigationBloc();
  }

  @override
  void dispose() {
    _navigationBloc.close();
    super.dispose();
  }

  /// Items list
  List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.access_alarm),
      title: Text('Alert'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text('Settings'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _navigationBloc.itemStream,
      initialData: _navigationBloc.defaultItem,
      builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
        return BottomNavigationBar(
          fixedColor: Colors.blueAccent,
          currentIndex: snapshot.data.index,
          onTap: _navigationBloc.pickItem,
          items: _items,
        );
      },
    );
  }
}
