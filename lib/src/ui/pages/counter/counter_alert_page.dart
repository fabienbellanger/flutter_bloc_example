import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/increment_bloc.dart';

///
/// CounterAlert class
///
class CounterAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc _incrementBloc = BlocProvider.of<IncrementBloc>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('ALERT'),
          RaisedButton(
            child: const Text('Decrement'),
            onPressed: () {
              if (_incrementBloc.counter > 0) {
                _incrementBloc.updateCounter.add("delete");
              }
            },
          ),
        ],
      ),
    );
  }
}
