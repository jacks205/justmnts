import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justmnts/models/Adjustment.dart';
import 'package:justmnts/models/Position.dart';

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
                    Text('Big Bang'),
                    Text('Birth of the Sun'),
                    Text('Earth is Born'),
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
        child: Column(
          children: [
            Container(
              color: Colors.amber,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text('Summary'),
                            Text(position.title),
                            Text(position.createdAt.toIso8601String()),
                            Text(
                                'Net Options: ${position.netOptions.toString()}'),
                            Text(
                                'Net Stocks: ${position.netStocks.toString()}'),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Text('Bottom')
          ],
        ),
      ),
    );
  }
}
