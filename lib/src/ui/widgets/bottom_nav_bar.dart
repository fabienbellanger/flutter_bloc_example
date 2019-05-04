import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/navigation_bloc.dart';
import 'package:flutter_bloc_example/src/ui/widgets/bottom_nav_item_badge.dart';

///
/// BottomNavigationBar class
///
class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavigationBloc _navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return StreamBuilder(
      stream: _navigationBloc.itemStream,
      initialData: _navigationBloc.defaultItem,
      builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
        return BottomNavigationBar(
          fixedColor: Colors.blueAccent,
          currentIndex: snapshot.data.index,
          onTap: _navigationBloc.pickItem,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm),
              title: Text('Alert'),
            ),
            BottomNavigationBarItem(
              icon: BottomNavItemBadge(),
              title: Text('Settings'),
            ),
          ],
        );
      },
    );
  }
}
