import 'dart:collection';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:justmnts/models/Position.dart';

class MainStore extends ChangeNotifier {
  String title = 'My Positions';

  List<Position> _positions = [];
  bool hasFetched = false;
  UnmodifiableListView<Position> get activePositions =>
      UnmodifiableListView(_positions.where((element) => !element.isArchived));
  UnmodifiableListView<Position> get archivedPositions =>
      UnmodifiableListView(_positions.where((element) => element.isArchived));

  void fetchPositions() async {
    log('fetchPositions');
    List<Position> positions = await Future.delayed(Duration(seconds: 2))
        .then((value) => Future.value([
              Position(
                  title: 'TSLA Memes',
                  symbol: 'TSLA',
                  description: 'A meme place for TSLA',
                  adjustments: [],
                  createdAt: DateTime.now(),
                  isArchived: false),
              Position(
                  title: 'AMD Memes',
                  symbol: 'AMD',
                  description: 'A meme place for AMD',
                  adjustments: [],
                  createdAt: DateTime.now(),
                  isArchived: true),
            ]));
    _positions = positions;
    hasFetched = true;
    notifyListeners();
  }

  void createNewPosition(Position position) {
    // TODO: Firebase
    _positions.add(position);
    notifyListeners();
  }
}
