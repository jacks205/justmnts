import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justmnts/adjustments/AdjustmentRow.dart';

class OptionsRowWidget extends StatefulWidget implements AdjustmentRow {
  const OptionsRowWidget({Key key}) : super(key: key);

  static OptionsRowWidgetState of(BuildContext context) =>
      context.findAncestorStateOfType<OptionsRowWidgetState>();

  @override
  State<StatefulWidget> createState() => OptionsRowWidgetState();

  @override
  void save(BuildContext context) {
    OptionsRowWidget.of(context).save(context);
  }
}

class OptionsRowWidgetState extends State<OptionsRowWidget> {
  Color _color;
  DateTime _expirationDate = DateTime.now();
  int _strikePrice = 0;
  int _quantity = 0;
  int _price = 0;

  void save(BuildContext context) {}

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
        color: this._color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: MaterialButton(
                        child: Text(
                          "${_expirationDate.month}-${_expirationDate.day}-${_expirationDate.year}",
                          style: TextStyle(fontSize: 14),
                          key: Key("dateText"),
                        ),
                        onPressed: () => _selectDate(context)))),
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
          ],
        ));
  }
}
