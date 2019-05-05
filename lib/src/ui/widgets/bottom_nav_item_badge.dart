import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/increment_bloc.dart';

///
/// BottomNavigationItem class
///
class BottomNavItemBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc _incrementBloc = BlocProvider.of<IncrementBloc>(context);

    return StreamBuilder(
      stream: _incrementBloc.outCounter,
      initialData: _incrementBloc.counterInitial,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        final widgets = <Widget>[
          Icon(Icons.notifications),
        ];

        if (snapshot.data > 0) {
          widgets.add(Positioned(
            top: -6.0,
            right: -6.0,
            child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(9.0),
              ),
              constraints: BoxConstraints(
                minWidth: 18.0,
                minHeight: 18.0,
              ),
              child: Text(
                snapshot.data.toString(),
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ));
        }

        return Stack(
          overflow: Overflow.visible,
          children: widgets,
        );
      },
    );
  }
}
