import 'package:flutter/cupertino.dart';
import 'package:justmnts/MainStore.dart';
import 'package:justmnts/models/Position.dart';

abstract class AdjustmentRow {
  void save(BuildContext context, Position position, MainStore model);
}
