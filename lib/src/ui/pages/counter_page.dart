import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/increment_bloc.dart';
import 'package:flutter_bloc_example/src/ui/widgets/bottom_nav_bar.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc bloc = BlocProvider.of<IncrementBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('BLoC version of the Counter App')),
      body: Center(
        child: StreamBuilder<int>(
            stream: bloc.outCounter,
            initialData: bloc.counterInitial,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text('You hit me: ${snapshot.data} times');
            }),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              bloc.updateCounter.add("add");
            },
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              bloc.updateCounter.add("remove");
            },
          ),
        ],
      ),
    );
  }
}
