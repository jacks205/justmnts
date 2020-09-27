import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionsRowWidget extends StatefulWidget {
  final Color color;
  const OptionsRowWidget({Key key, this.color}) : super(key: key);
  @override
  State<StatefulWidget> createState() =>
      OptionsRowWidgetState(color: this.color);
}

class OptionsRowWidgetState extends State<OptionsRowWidget> {
  Color color;
  OptionsRowWidgetState({this.color});

  DateTime _selectedDate = DateTime.now();

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
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: MaterialButton(
                        child: Text(
                          "${_selectedDate.month}-${_selectedDate.day}-${_selectedDate.year}",
                          style: TextStyle(fontSize: 14),
                          key: Key("dateText"),
                        ),
                        onPressed: () => _selectDate(context)))),
            Flexible(
                flex: 1,
                child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Strike price",
                      labelText: "Strike price",
                    ))),
            Flexible(
                flex: 1,
                child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Quantity",
                      labelText: "Quantity",
                    ))),
            Flexible(
                flex: 1,
                child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Amount",
                      hintText: "Amount",
                    ))),
          ],
        ));
  }
}
