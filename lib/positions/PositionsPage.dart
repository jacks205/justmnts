import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../MainStore.dart';

class PositionsPage extends StatelessWidget {
  final String title;
  const PositionsPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(this.title),
        ),
        body: Consumer<MainStore>(
          builder: (context, model, child) => Container(
            child: Text(model.title),
          ),
          child: Container(),
        ),
        floatingActionButton: FloatingActionButton(
          // onPressed: _incrementCounter,
          tooltip: 'Add Position',
          child: Icon(Icons.add),
        ));
  }
}
