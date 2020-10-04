import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:justmnts/models/Option.dart';

class OptionsRowWidget extends StatefulWidget {
  final OptionsRowWidgetState row = OptionsRowWidgetState();

  Option getOption(BuildContext context) {
    return row.getOption();
  }

  @override
  State<StatefulWidget> createState() => OptionsRowWidgetState();
}

class OptionsRowWidgetState extends State<OptionsRowWidget> {
  bool _isCredit = true;
  Color _dateButtonColor = Color.fromRGBO(0, 255, 0, 0.5);
  Color _rowColor = Color.fromRGBO(0, 153, 0, 1);
  Color _toggleButtonColor = Color.fromRGBO(153, 0, 0, 1);
  String _toggleButtonText = "Buy";
  DateTime _expirationDate = DateTime.now();
  int _strikePrice = 0;
  int _quantity = 0;
  int _price = 0;

  Option getOption() {
    return Option(
        expirationDate: _expirationDate,
        strikePrice: _strikePrice,
        quantity: _quantity,
        price: _price);
  }

  void _creditToggleChanged() {
    setState(() {
      _isCredit = !_isCredit;
      _toggleButtonColor = _isCredit
          ? Color.fromRGBO(153, 0, 0, 1)
          : Color.fromRGBO(0, 153, 0, 1);
      _rowColor = _isCredit
          ? Color.fromRGBO(0, 153, 0, 1)
          : Color.fromRGBO(153, 0, 0, 1);
      _dateButtonColor = _isCredit
          ? Color.fromRGBO(0, 255, 0, 0.5)
          : Color.fromRGBO(255, 0, 0, 0.5);
      _toggleButtonText = _isCredit ? "Buy" : "Sell";
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _expirationDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _expirationDate) {
      setState(() {
        _expirationDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        color: this._rowColor,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    flex: 1,
                    child: MaterialButton(
                        color: _dateButtonColor,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          DateFormat("M/d/yy").format(_expirationDate),
                          style: TextStyle(fontSize: 14),
                          key: Key("dateText"),
                        ),
                        onPressed: () => _selectDate(context))),
                Flexible(
                    flex: 1,
                    child: TextFormField(
                        initialValue: _strikePrice.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _strikePrice = int.parse(value);
                        },
                        decoration: InputDecoration(
                          hintText: "Strike price",
                          labelText: "Strike price",
                        ))),
                Flexible(
                    flex: 1,
                    child: TextFormField(
                        initialValue: _quantity.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _quantity = int.parse(value);
                        },
                        decoration: InputDecoration(
                          hintText: "Quantity",
                          labelText: "Quantity",
                        ))),
                Flexible(
                    flex: 1,
                    child: TextFormField(
                        initialValue: _price.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _price = int.parse(value);
                        },
                        decoration: InputDecoration(
                          labelText: "Price",
                          hintText: "Price",
                        ))),
                Flexible(
                    flex: 1,
                    child: MaterialButton(
                      color: _toggleButtonColor,
                      onPressed: () => _creditToggleChanged(),
                      child: Text(_toggleButtonText,
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    )),
              ],
            )));
  }
}
