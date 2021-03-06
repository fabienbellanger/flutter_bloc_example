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

class _CounterHomeState extends State<CounterHome> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animationSize;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animationController.addListener(() {
      print('ici');
      setState(() {});
    });
    _animationSize = Tween(begin: 5.0, end: 64.0).animate(_animationController);
    _animationController.forward();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final IncrementBloc _incrementBloc = BlocProvider.of<IncrementBloc>(context);

    return Center(
      child: StreamBuilder<int>(
          stream: _incrementBloc.outCounter,
          initialData: _incrementBloc.counter,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            double size = _animationSize?.value;
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedSwitcher(
                    // animation: _animationController,
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(child: child, scale: animation);
                    },
                    child: Text(
                      snapshot.data.toString(),
                      key: ValueKey<int>(snapshot.data),
                      style: TextStyle(
                        fontSize: size,
                        color: Colors.blue,
                      ),
                    ),
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
            }
            return Container();
          }),
    );
  }
}
