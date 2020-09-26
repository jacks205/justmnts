import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'Option.dart';
import 'Stock.dart';

class Adjustment {
  final String title;
  final String note;
  final DateTime createdAt;
  final List<Option> options;
  final List<Stock> stocks;
  Adjustment({
    this.title,
    this.note,
    this.createdAt,
    this.options,
    this.stocks,
  });

  Adjustment copyWith({
    String title,
    String note,
    DateTime createdAt,
    List<Option> options,
    List<Stock> stocks,
  }) {
    return Adjustment(
      title: title ?? this.title,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      options: options ?? this.options,
      stocks: stocks ?? this.stocks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'note': note,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'options': options?.map((x) => x?.toMap())?.toList(),
      'stocks': stocks?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Adjustment.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Adjustment(
      title: map['title'],
      note: map['note'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      options: List<Option>.from(map['options']?.map((x) => Option.fromMap(x))),
      stocks: List<Stock>.from(map['stocks']?.map((x) => Stock.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Adjustment.fromJson(String source) =>
      Adjustment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Adjustment(title: $title, note: $note, createdAt: $createdAt, options: $options, stocks: $stocks)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Adjustment &&
        o.title == title &&
        o.note == note &&
        o.createdAt == createdAt &&
        listEquals(o.options, options) &&
        listEquals(o.stocks, stocks);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        note.hashCode ^
        createdAt.hashCode ^
        options.hashCode ^
        stocks.hashCode;
  }
}
