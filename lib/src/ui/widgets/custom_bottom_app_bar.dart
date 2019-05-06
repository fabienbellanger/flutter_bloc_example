import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/navigation_bloc.dart';
import 'package:flutter_bloc_example/src/ui/widgets/custom_bottom_app_item_badge.dart';

///
/// CustomBottomAppBar class
///
class CustomBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavigationBloc _navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return StreamBuilder(
      stream: _navigationBloc.itemStream,
      initialData: _navigationBloc.defaultItem,
      builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
        return BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                iconSize: 35.0,
                color: Colors.grey,
                onPressed: () {
                  _navigationBloc.pickItem(0);
                },
              ),
              IconButton(
                icon: CustomBottomAppItemBadge(),
                iconSize: 35.0,
                color: Colors.grey,
                onPressed: () {
                  _navigationBloc.pickItem(1);
                },
              ),
            ],
          ),
          shape: CircularNotchedRectangle(),
          notchMargin: 5.0,
          color: Colors.white,
        );
      },
    );
  }
}