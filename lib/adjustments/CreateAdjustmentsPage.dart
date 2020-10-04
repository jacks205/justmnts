import 'package:flutter/material.dart';
import 'package:justmnts/models/Position.dart';
import 'package:justmnts/adjustments/AdjustmentsWidget.dart';

class CreateAdjustmentsPage extends StatelessWidget {
  const CreateAdjustmentsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Position position = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create adjustment"),
      ),
      body: AdjustmentsWidget(position: position),
    );
  }
}
