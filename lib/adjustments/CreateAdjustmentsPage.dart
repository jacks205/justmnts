import 'package:flutter/material.dart';
import 'package:justmnts/adjustments/AdjustmentsWidget.dart';

class CreateAdjustmentsPage extends StatelessWidget {
  const CreateAdjustmentsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create adjustment"),
      ),
      body: AdjustmentsWidget(),
    );
  }
}
