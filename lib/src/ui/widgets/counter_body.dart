import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/navigation_bloc.dart';
import 'package:flutter_bloc_example/src/ui/pages/counter/counter_alert_page.dart';
import 'package:flutter_bloc_example/src/ui/pages/counter/counter_home_page.dart';

///
/// CounterBody class
///
class CounterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavigationBloc _navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return Center(
      child: StreamBuilder(
        stream: _navigationBloc.itemStream,
        initialData: _navigationBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.HOME:
              return CounterHome();
            case NavBarItem.ALERT:
              return CounterAlert();
          }
        },
      ),
    );
  }
}
