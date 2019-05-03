import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/increment_bloc.dart';
import 'package:flutter_bloc_example/src/blocs/navigation_bloc.dart';

///
/// CounterBody class
///
class CounterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc _incrementBloc =
        BlocProvider.of<IncrementBloc>(context);
    final NavigationBloc _navigationBloc =
        BlocProvider.of<NavigationBloc>(context);

    return Center(
      child: StreamBuilder<int>(
          stream: _incrementBloc.outCounter,
          initialData: _incrementBloc.counterInitial,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('You hit me: ${snapshot.data} times'),
                StreamBuilder(
                  stream: _navigationBloc.itemStream,
                  initialData: _navigationBloc.defaultItem,
                  builder: (BuildContext context,
                      AsyncSnapshot<NavBarItem> snapshot) {
                    switch (snapshot.data) {
                      case NavBarItem.HOME:
                        return Text('HOME');
                      case NavBarItem.ALERT:
                        return Text('ALERT');
                      case NavBarItem.SETTINGS:
                        return Text('SETTINGS');
                    }
                  },
                )
              ],
            );
          }),
    );
  }
}
