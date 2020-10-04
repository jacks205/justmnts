import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:intl/intl.dart";
import 'package:justmnts/MainStore.dart';
import 'package:justmnts/adjustments/AdjustmentRow.dart';
import 'package:justmnts/models/Adjustment.dart';
import 'package:justmnts/models/Position.dart';
import 'package:justmnts/models/Stock.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter =
        NumberFormat.simpleCurrency(decimalDigits: 2, locale: "en_US");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class StockRowWidget extends StatefulWidget {
  final StockRowWidgetState _row = StockRowWidgetState();

  static StockRowWidgetState of(BuildContext context) =>
      context.findAncestorStateOfType<StockRowWidgetState>();

  Stock getStock(BuildContext context) {
    return _row.getStock();
  }

  @override
  State<StatefulWidget> createState() => _row;
}

class StockRowWidgetState extends State<StockRowWidget> {
  bool _isCredit = true;
  Color _rowColor = Color.fromRGBO(0, 153, 0, 1);
  Color _toggleButtonColor = Color.fromRGBO(153, 0, 0, 1);
  String _toggleButtonText = "Buy";
  int _quantity = 0;
  int _price = 0;

  Stock getStock() {
    return Stock(price: _price, quantity: _quantity);
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
      _toggleButtonText = _isCredit ? "Buy" : "Sell";
    });
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
                    flex: 3,
                    child: TextFormField(
                        initialValue: _quantity.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _quantity = int.parse(value);
                        },
                        decoration: InputDecoration(
                          hintText: "# of shares",
                          labelText: "# of shares",
                        ))),
                Flexible(
                    flex: 4,
                    child: TextFormField(
                        initialValue: _price.toString(),
                        inputFormatters: [CurrencyInputFormatter()],
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _price = int.parse(value);
                        },
                        decoration: InputDecoration(
                          labelText: "Price per share",
                          hintText: "Price per share",
                        ))),
                Flexible(
                    flex: 2,
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
