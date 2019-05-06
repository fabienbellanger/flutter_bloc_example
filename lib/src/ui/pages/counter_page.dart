import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/increment_bloc.dart';
import 'package:flutter_bloc_example/src/ui/widgets/counter_body.dart';
import 'package:flutter_bloc_example/src/ui/widgets/custom_bottom_app_bar.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc _incrementBloc = BlocProvider.of<IncrementBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('BLoC version of the Counter App')),
      body: CounterBody(),
      bottomNavigationBar: CustomBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        elevation: 2.0,
        child: const Icon(Icons.add),
        onPressed: () {
          _incrementBloc.updateCounter.add("add");
        },
      ),
    );
  }
}
