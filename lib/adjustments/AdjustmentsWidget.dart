import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justmnts/adjustments/AddStockOrOptionRowWidget.dart';
import 'package:justmnts/adjustments/OptionsRowWidget.dart';
import 'package:justmnts/adjustments/StockRowWidget.dart';
import 'package:justmnts/models/Adjustment.dart';
import 'package:justmnts/models/Option.dart';
import 'package:justmnts/models/Position.dart';
import 'package:justmnts/adjustments/AdjustmentRow.dart';
import 'package:justmnts/models/Stock.dart';
import 'package:provider/provider.dart';

import '../MainStore.dart';

class AdjustmentsWidget extends StatefulWidget {
  final Position position;
  const AdjustmentsWidget({Key key, this.position}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AdjustmentsWidgetState(position: this.position);
}

class _AdjustmentsWidgetState extends State<AdjustmentsWidget> {
  _AdjustmentsWidgetState({this.position});
  final Position position;
  String _title;
  String _notes;
  DateTime _selectedDate = DateTime.now();
  List<Widget> _optionsAndStocksWidgets = List<Widget>();
  void Function(MainStore model) _saveOnPress;

  void _addOptions() {
    setState(() {
      _optionsAndStocksWidgets.add(OptionsRowWidget());
    });
  }

  void _addStock() {
    setState(() {
      _optionsAndStocksWidgets.add(StockRowWidget());
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget buildErrorOrEmpty() {
    final Position position = ModalRoute.of(context).settings.arguments;

    if (_optionsAndStocksWidgets.isEmpty) {
      this._saveOnPress = null;
      return AddStockOrOptionRowWidget();
    } else {
      this._saveOnPress = (MainStore model) {
        List<Stock> stocks = List<Stock>();
        List<Option> options = List<Option>();

        this._optionsAndStocksWidgets.forEach((element) {
          if (element is StockRowWidget) {
            stocks.add(element.getStock(context));
          } else if (element is OptionsRowWidget) {
            options.add(element.getOption(context));
          }
        });

        model.addAdjustment(
            Adjustment(
                title: _title,
                note: _notes,
                createdAt: DateTime.now(),
                stocks: stocks,
                options: options),
            position);

        Navigator.of(context).pop();
      };
      return Column(children: _optionsAndStocksWidgets);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
          child: Column(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                    flex: 2,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: TextField(
                            onChanged: (text) {
                              _title = text;
                            },
                            decoration: InputDecoration(
                              hintText: "Adjustment Title",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            )))),
                Flexible(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: RaisedButton(
                            child: Text(
                              "${_selectedDate.month}-${_selectedDate.day}-${_selectedDate.year}",
                              style: TextStyle(fontSize: 18),
                              key: Key("dateText"),
                            ),
                            onPressed: () => _selectDate(context))))
              ],
            )),
        buildErrorOrEmpty(),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
                onChanged: (text) {
                  _notes = text;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                minLines: 6,
                decoration: InputDecoration(
                  hintText: "Notes",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ))),
        // AdjustmentSummaryWidget(),
        Consumer<MainStore>(
            builder: (context, model, child) => MaterialButton(
                  onPressed: () => _saveOnPress(model),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )),
      ])),
      Align(
          alignment: FractionalOffset.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    splashColor: Theme.of(context).splashColor,
                    disabledColor: Theme.of(context).disabledColor,
                    onPressed: () => _addOptions(),
                    child: Text(
                      "Add option",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    disabledColor: Theme.of(context).disabledColor,
                    onPressed: () => _addStock(),
                    child: Text("Add stock",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ))
            ],
          ))
    ]);
  }
}
