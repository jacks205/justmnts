import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:justmnts/MainStore.dart';
import 'package:justmnts/models/Position.dart';
import 'package:provider/provider.dart';

Widget createTextField(String placeholder, ValueChanged<String> onChanged) =>
    Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: TextField(
            onChanged: onChanged,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintText: placeholder,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            )));

class CreatePositionPage extends StatefulWidget {
  CreatePositionPage({Key key}) : super(key: key);

  @override
  _CreatePositionPageState createState() => _CreatePositionPageState();
}

class _CreatePositionPageState extends State<CreatePositionPage> {
  String _newTitle;
  String _newDescription;
  String _newSymbol;
  String _error;

  Position _createPosition(BuildContext context, MainStore model) {
    try {
      if (_newTitle == null) {
        throw ('Title incorrect');
      }
      String title = _newTitle;
      if (_newDescription == null) {
        throw ('Description incorrect');
      }
      String description = _newDescription;
      if (_newSymbol == null) {
        throw ('Symbol incorrect');
      }
      String symbol = _newSymbol.toUpperCase();
      Position position = Position(
        title: title,
        description: description,
        symbol: symbol,
      );
      log(position.toString());
      model.createNewPosition(position);
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _error = e;
      });
    }
  }

  Widget buildErrorOrEmpty() {
    if (_error != null) {
      return Text(_error);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Create a New Position'),
        ),
        body: SafeArea(
          bottom: true,
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    buildErrorOrEmpty(),
                    createTextField('Title', (value) {
                      this._newTitle = value;
                      log(this._newTitle);
                    }),
                    createTextField('Description', (value) {
                      this._newDescription = value;
                      log(this._newDescription);
                    }),
                    createTextField('Symbol', (value) {
                      setState(() {
                        this._newSymbol = value;
                      });
                      log(this._newSymbol);
                    }),
                  ],
                ),
              ),
              Spacer(),
              Consumer<MainStore>(
                builder: (context, model, child) => MaterialButton(
                  onPressed: () => _createPosition(context, model),
                  color: Theme.of(context).accentColor,
                  height: 40.0,
                  child: Text('Create $_newSymbol Position'),
                ),
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ));
  }
}
