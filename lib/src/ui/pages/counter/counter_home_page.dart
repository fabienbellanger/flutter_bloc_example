import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/increment_bloc.dart';

///
/// CounterHome class
///
class CounterHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc _incrementBloc = BlocProvider.of<IncrementBloc>(context);

    return Center(
      child: StreamBuilder<int>(
          stream: _incrementBloc.outCounter,
          initialData: _incrementBloc.counter,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('You hit me: ${snapshot.data} times'),
                Text('HOME'),
              ],
            );
          }),
    );
  }
}
