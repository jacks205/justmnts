import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:justmnts/models/Adjustment.dart';
import 'package:justmnts/models/Option.dart';
import 'package:justmnts/models/Position.dart';
import 'package:justmnts/models/Stock.dart';

class MainStore extends ChangeNotifier {
  String title = 'My Positions';
  int _selectedPositionIndex = -1;

  List<Position> _positions = [];
  bool hasFetched = false;
  List<Position> get activePositions =>
      _positions.where((element) => !element.isArchived).toList();
  List<Position> get archivedPositions =>
      _positions.where((element) => element.isArchived).toList();

  BuildContext positionsContext;
  MainStore({this.positionsContext});

  void fetchPositions(BuildContext context) async {
    log('fetchPositions');
    // List<Position> positions = await Future.delayed(Duration(milliseconds: 500))
    //     .then((value) => Future.value([
    //           Position(
    //               title: 'TSLA Memes',
    //               symbol: 'TSLA',
    //               description: 'A meme place for TSLA',
    //               adjustments: [
    //                 Adjustment(
    //                     title: 'TSLA Adjustment 1',
    //                     note:
    //                         "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
    //                     options: [
    //                       Option(
    //                           expirationDate: DateTime.parse('2020-11-20'),
    //                           strikePrice: 400,
    //                           quantity: -1,
    //                           price: -50),
    //                       Option(
    //                           expirationDate: DateTime.parse('2020-11-20'),
    //                           strikePrice: 300,
    //                           quantity: 1,
    //                           price: 300),
    //                     ],
    //                     stocks: [
    //                       Stock(quantity: 100, price: 420),
    //                       Stock(quantity: 50, price: 390),
    //                     ],
    //                     createdAt: DateTime.now()),
    //                 Adjustment(
    //                     title: 'TSLA Adjustment 2',
    //                     note:
    //                         "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
    //                     options: [
    //                       Option(
    //                           expirationDate: DateTime.parse('2020-11-20'),
    //                           strikePrice: 400,
    //                           quantity: 1,
    //                           price: 200),
    //                       Option(
    //                           expirationDate: DateTime.parse('2020-11-20'),
    //                           strikePrice: 300,
    //                           quantity: 1,
    //                           price: 300),
    //                     ],
    //                     stocks: [
    //                       Stock(quantity: 100, price: 420),
    //                       Stock(quantity: 50, price: 390),
    //                     ],
    //                     createdAt: DateTime.now().add(Duration(days: 2))),
    //                 Adjustment(
    //                     title: 'TSLA Adjustment 3',
    //                     note:
    //                         "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
    //                     options: [
    //                       Option(
    //                           expirationDate: DateTime.parse('2020-11-20'),
    //                           strikePrice: 400,
    //                           quantity: 1,
    //                           price: -200),
    //                       Option(
    //                           expirationDate: DateTime.parse('2020-11-20'),
    //                           strikePrice: 300,
    //                           quantity: 1,
    //                           price: 300),
    //                     ],
    //                     stocks: [
    //                       Stock(quantity: 100, price: 420),
    //                       Stock(quantity: 50, price: 390),
    //                     ],
    //                     createdAt: DateTime.now().add(Duration(days: 2))),
    //               ],
    //               createdAt: DateTime.now(),
    //               isArchived: false),
    //           Position(
    //               title: 'AMD Memes',
    //               symbol: 'AMD',
    //               description: 'A meme place for AMD',
    //               adjustments: [],
    //               createdAt: DateTime.now(),
    //               isArchived: true),
    //         ]));
    // _positions = positions;
    hasFetched = true;
    notifyListeners();
  }

  void createNewPosition(Position position) {
    // TODO: Firebase
    int oldLength = _positions.length;
    _positions.add(position);
    log(positionsContext.toString());
    if (oldLength < _positions.length) {
      log('Position added!');
      Scaffold.of(positionsContext).showSnackBar(SnackBar(
        content: Text('Position added!'),
      ));
    } else if (oldLength > _positions.length) {
      log('Position removed!');
      Scaffold.of(positionsContext).showSnackBar(SnackBar(
        content: Text('Position removed!'),
      ));
    }
    notifyListeners();
  }

  void addAdjustment(Adjustment adj, Position position) {
    final Position currentPosition =
        _positions.firstWhere((element) => element == position);
    currentPosition.adjustments.add(adj);

    log(positionsContext.toString());
    log('Adjustment added!');
    Scaffold.of(positionsContext).showSnackBar(SnackBar(
      content: Text('Adjustment added!'),
    ));

    notifyListeners();
  }
}
