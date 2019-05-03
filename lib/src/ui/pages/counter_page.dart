import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/increment_bloc.dart';
import 'package:flutter_bloc_example/src/ui/widgets/bottom_nav_bar.dart';
import 'package:flutter_bloc_example/src/ui/widgets/counter_body.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc _incrementBloc =
        BlocProvider.of<IncrementBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('BLoC version of the Counter App')),
      body: CounterBody(),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              _incrementBloc.updateCounter.add("add");
            },
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              _incrementBloc.updateCounter.add("remove");
            },
          ),
        ],
      ),
    );
  }
}
