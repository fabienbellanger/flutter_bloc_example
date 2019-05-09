import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc_example/src/blocs/bloc_provider.dart';
import 'package:flutter_bloc_example/src/blocs/navigation_bloc.dart';
import 'package:flutter_bloc_example/src/models/Category.dart';

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavigationBloc _navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return StreamBuilder(
      stream: _navigationBloc.outTabBarItems,
      initialData: _navigationBloc.tabBarItems,
      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
        print(snapshot.data.length);
        return DefaultTabController(
          length: snapshot.data.length,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 24.0),
                tabs: _getTabs(snapshot.data),
              ),
              title: Text('Tabs Demo'),
            ),
            body: TabBarView(
              children: _getTabsContent(snapshot.data),
            ),
          ),
        );
      },
    );
  }

  /// Returns TabBar items list
  List<Tab> _getTabs(List<Category> categories) {
    List<Tab> tabs = new List();

    for (var category in categories) {
      tabs.add(Tab(
        icon: Icon(IconData(category.icon, fontFamily: 'MaterialIcons')),
        text: category.label,
      ));
    }

    return tabs;
  }

  /// Returns TabBar items content
  List<Widget> _getTabsContent(List<Category> categories) {
    List<Widget> tabsContent = new List();

    for (var category in categories) {
      tabsContent.add(Icon(IconData(category.icon, fontFamily: 'MaterialIcons')));
    }

    return tabsContent;
  }
}
