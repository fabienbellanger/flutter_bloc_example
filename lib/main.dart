import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/increment_bloc.dart';
import 'package:flutter_bloc_example/src/blocs/navigation_bloc.dart';
import 'package:flutter_bloc_example/src/ui/pages/counter_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<NavigationBloc>(
        bloc: NavigationBloc(),
        child: BlocProvider<IncrementBloc>(
          bloc: IncrementBloc(),
          child: CounterPage(),
        ),
      ),
    );
  }
}

class TestStreamBuilder extends StatefulWidget {
  @override
  _TestStreamBuilderState createState() => _TestStreamBuilderState();
}

class _TestStreamBuilderState extends State<TestStreamBuilder> with TickerProviderStateMixin {
  Stream<int> stream;
  AnimationController controller;
  Animation colorAnimation;

  @override
  void initState() {
    super.initState();
    stream = Stream.periodic(Duration(milliseconds: 1000), (i) => i).take(10);
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    colorAnimation = ColorTween(begin: Colors.white, end: Colors.orange).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        child: FittedBox(
          child: StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                controller.forward(from: 0.0);
                return AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, Widget child) {
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(color: colorAnimation.value),
                    );
                  },
                );
              }
              return Container();
            },
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
