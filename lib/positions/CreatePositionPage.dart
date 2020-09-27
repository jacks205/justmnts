import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreatePositionPage extends StatelessWidget {
  final String title;
  const CreatePositionPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Create a New Position'),
      ),
      body: Container(),
    );
  }
}
