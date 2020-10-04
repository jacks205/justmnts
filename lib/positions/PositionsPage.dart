import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:justmnts/models/Position.dart';
import 'package:justmnts/positions/ViewPositionsPage.dart';
import 'package:provider/provider.dart';

import '../MainStore.dart';

class PositionsPage extends StatelessWidget {
  final String title;
  const PositionsPage({Key key, this.title}) : super(key: key);

  void _navigateToPositionPage(BuildContext context, Position position) {
    Navigator.of(context)
        .pushNamed(ViewPositionsPage.routeName, arguments: position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(this.title),
        ),
        body: Consumer<MainStore>(
          builder: (context, model, child) {
            model.positionsContext = context;
            if (!model.hasFetched) {
              model.fetchPositions(context);
              return Text('is loading...');
            }
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: model.activePositions.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      log(index.toString());
                      log(model.activePositions[index].toString());
                      _navigateToPositionPage(
                          context, model.activePositions[index]);
                    },
                    child: Container(
                      height: 50,
                      child: Center(
                          child: Text(
                              '${model.activePositions[index].toString()}')),
                    ),
                  );
                });
          },
          child: Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed('/createPosition'),
          tooltip: 'Add Position',
          child: Icon(Icons.add),
        ));
  }
}
