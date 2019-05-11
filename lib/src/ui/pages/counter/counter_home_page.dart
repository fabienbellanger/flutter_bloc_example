import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/increment_bloc.dart';
import 'package:flutter_bloc_example/src/blocs/navigation_bloc.dart';
import 'package:flutter_bloc_example/src/ui/pages/tabbar_page.dart';

///
/// CounterHome class
///
class CounterHome extends StatefulWidget {
  @override
  _CounterHomeState createState() => _CounterHomeState();
}

class _CounterHomeState extends State<CounterHome> {
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
                TextCounter(
                  counter: snapshot.data,
                ),
                RaisedButton(
                  color: Colors.orange,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white70,
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'Go to TabBar Page',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return BlocProvider<NavigationBloc>(
                        bloc: NavigationBloc(),
                        child: TabBarPage(),
                      );
                    }));
                  },
                ),
              ],
            );
          }),
    );
  }
}

class TextCounter extends StatefulWidget {
  final int counter;

  const TextCounter({Key key, this.counter}) : super(key: key);

  @override
  _TextCounterState createState() => _TextCounterState();
}

class _TextCounterState extends State<TextCounter> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animationSize;
  int counter;

  @override
  void initState() {
    super.initState();

    counter = widget.counter;

    _animationController = new AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animationController.addListener(() {
      setState(() {});
    });

    _animationSize = new Tween(begin: 5.0, end: 64.0).animate(_animationController);

    _animationController.forward();
  }

  @override
  void didUpdateWidget(TextCounter oldWidget) {
    if (counter != widget.counter) {
      setState(() {
        counter = widget.counter;

        print('didUpdateWidget');
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = _animationSize?.value;

    return Text(
      counter.toString(),
      style: TextStyle(
        fontSize: size,
        color: Colors.blue,
      ),
    );
  }
}
