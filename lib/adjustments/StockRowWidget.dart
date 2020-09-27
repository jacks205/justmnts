import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:intl/intl.dart";

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter =
        NumberFormat.simpleCurrency(decimalDigits: 10, locale: "en_US");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class StockRowWidget extends StatefulWidget {
  final Color color;
  const StockRowWidget({Key key, this.color}) : super(key: key);
  @override
  State<StatefulWidget> createState() => StockRowWidgetState(color: this.color);
}

class StockRowWidgetState extends State<StockRowWidget> {
  Color color;
  StockRowWidgetState({this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        color: this.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: TextField(
                    keyboardType: TextInputType.number,
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
                child: TextField(
                    inputFormatters: [CurrencyInputFormatter()],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Price per share",
                      hintText: "Price per share",
                    ))),
          ],
        ));
  }
}
