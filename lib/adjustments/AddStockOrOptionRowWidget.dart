import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddStockOrOptionRowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 20, 20),
          child: Text(
            "Press add option or add stock",
            style: TextStyle(fontSize: 18),
            key: Key("dateText"),
          )),
    );
  }
}
