import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:justmnts/models/Adjustment.dart';

import 'Option.dart';

class Position {
  final String title;
  final String description;
  final String symbol;
  final DateTime createdAt;
  final List<Adjustment> adjustments;
  final bool isArchived;
  Position({
    this.title,
    this.description,
    this.symbol,
    DateTime createdAt,
    List<Adjustment> adjustments,
    isArchived,
  })  : createdAt = createdAt ?? DateTime.now(),
        adjustments = adjustments ?? List<Adjustment>(),
        isArchived = isArchived ?? false;

  Position copyWith({
    String title,
    String description,
    String symbol,
    DateTime createdAt,
    List<Adjustment> adjustments,
    bool isArchived,
  }) {
    return Position(
      title: title ?? this.title,
      description: description ?? this.description,
      symbol: symbol ?? this.symbol,
      createdAt: createdAt ?? this.createdAt,
      adjustments: adjustments ?? this.adjustments,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'symbol': symbol,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'adjustments': adjustments?.map((x) => x?.toMap())?.toList(),
      'isArchived': isArchived,
    };
  }

  factory Position.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Position(
      title: map['title'],
      description: map['description'],
      symbol: map['symbol'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      adjustments: List<Adjustment>.from(
          map['adjustments']?.map((x) => Adjustment.fromMap(x))),
      isArchived: map['isArchived'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Position.fromJson(String source) =>
      Position.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Position(title: $title, description: $description, symbol: $symbol, createdAt: $createdAt, adjustments: $adjustments, isArchived: $isArchived)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Position &&
        o.title == title &&
        o.description == description &&
        o.symbol == symbol &&
        o.createdAt == createdAt &&
        listEquals(o.adjustments, adjustments) &&
        o.isArchived == isArchived;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        symbol.hashCode ^
        createdAt.hashCode ^
        adjustments.hashCode ^
        isArchived.hashCode;
  }

  Map<String, MutableOption> get openPositionsMap {
    Map<String, MutableOption> map = {};
    adjustments.forEach((adjustment) {
      adjustment.options.forEach((option) {
        String optionHash = option.positionHash;
        if (map[optionHash] == null) {
          map[optionHash] = MutableOption(
              expirationDate: option.expirationDate,
              strikePrice: option.strikePrice);
        }
        map[optionHash].quantity = map[optionHash].quantity + option.quantity;
        map[optionHash].price = map[optionHash].price + option.price;
      });
    });
    log(map.toString());
    return map;
  }

  List<Option> get openPositions {
    List<Option> options = [];
    Map<String, MutableOption> map = openPositionsMap;
    map.forEach((key, value) {
      if (value.quantity != 0) {
        options.add(value);
      }
    });
    return options;
  }

  int get netOptions => adjustments
      .map((e) => e.calculateNetOptions)
      .reduce((value, element) => value + element);
  int get netStocks => adjustments
      .map((e) => e.calculateNetStocks)
      .reduce((value, element) => value + element);
}

class MutableOption extends Option {
  DateTime expirationDate;
  int strikePrice;
  int quantity;
  int price;
  MutableOption({
    this.expirationDate,
    this.strikePrice,
    this.quantity = 0,
    this.price = 0,
  });
}
