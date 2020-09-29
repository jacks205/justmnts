import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:intl/intl.dart";
import 'package:justmnts/adjustments/AdjustmentRow.dart';

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

class StockRowWidget extends StatefulWidget implements AdjustmentRow {
  const StockRowWidget({Key key}) : super(key: key);

  static StockRowWidgetState of(BuildContext context) =>
      context.findAncestorStateOfType<StockRowWidgetState>();

  @override
  State<StatefulWidget> createState() => StockRowWidgetState();

  @override
  void save(BuildContext context) {
    StockRowWidget.of(context).save(context);
  }
}

class StockRowWidgetState extends State<StockRowWidget> {
  Color _color;
  int _quantity = 0;
  int _price = 0;

  void save(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        color: this._color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: TextFormField(
                    initialValue: _quantity.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _quantity = int.parse(value);
                    },
                    decoration: InputDecoration(
                      hintText: "#",
                      labelText: "#",
                    ))),
            Flexible(
                flex: 3,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 20, 0),
                    child: Text(
                      "Shares",
                      style: TextStyle(fontSize: 18),
                      key: Key("dateText"),
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
          ],
        ));
  }
}
