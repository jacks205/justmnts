import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justmnts/models/Adjustment.dart';
import 'package:justmnts/models/Position.dart';
import 'package:provider/provider.dart';

import '../MainStore.dart';
import '../main.dart';

class ViewPositionsPage extends StatelessWidget {
  static final String routeName = '/position';
  const ViewPositionsPage({Key key}) : super(key: key);

  Column _buildAdjustmentList(List<Adjustment> adjustments) {
    DateFormat formatter = DateFormat.yMd();
    return Column(
      children: adjustments
          .asMap()
          .entries
          .map((entry) => Card(
                child: ExpansionTile(
                  initiallyExpanded: entry.key == 0,
                  title: Text(entry.value.title),
                  subtitle: Text(formatter.format(entry.value.createdAt)),
                  children: <Widget>[
                    Text(entry.value.note),
                  ],
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Position position = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(position.title),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Consumer<MainStore>(
            builder: (context, model, child) => Column(
              children: [
                Text('Summary'),
                Text(position.title),
                Text(position.createdAt.toIso8601String()),
                Text('Net Options: ${position.netOptions.toString()}'),
                Text('Net Stocks: ${position.netStocks.toString()}'),
                Column(
                  children: position.openPositions.map((element) {
                    DateFormat formatter = DateFormat(
                        '${DateFormat.DAY} ${DateFormat.ABBR_MONTH}');
                    return Text(
                        '${formatter.format(element.expirationDate)} - \$${element.strikePrice}, ${element.quantity}, Net: ${element.price}');
                  }).toList(),
                ),
                _buildAdjustmentList(position.adjustments)
              ],
            ),
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .pushNamed(createAdjustmentPage, arguments: position),
          tooltip: 'Add Adjustment',
          child: Icon(Icons.add),
        ));
  }
}
