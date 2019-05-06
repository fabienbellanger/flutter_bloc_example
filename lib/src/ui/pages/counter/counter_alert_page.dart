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
          StreamBuilder(
              stream: _incrementBloc.outCounter,
              initialData: _incrementBloc.counter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return RaisedButton(
                  color: Colors.orange,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white70,
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'Decrement',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onPressed: (_incrementBloc.counter <= 0)
                      ? null
                      : () {
                          _incrementBloc.updateCounter.add("delete");
                        },
                );
              }),
        ],
      ),
    );
  }
}
