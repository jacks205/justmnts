import 'dart:convert';

import 'package:intl/intl.dart';

import 'Calculable.dart';

class Option implements Calculable {
  final DateTime expirationDate;
  final int strikePrice;
  final int quantity;
  final int price;
  Option({
    this.expirationDate,
    this.strikePrice,
    this.quantity,
    this.price,
  });

  Option copyWith({
    DateTime expirationDate,
    int strikePrice,
    int quantity,
    int price,
  }) {
    return Option(
      expirationDate: expirationDate ?? this.expirationDate,
      strikePrice: strikePrice ?? this.strikePrice,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expirationDate': expirationDate?.millisecondsSinceEpoch,
      'strikePrice': strikePrice,
      'quantity': quantity,
      'price': price,
    };
  }

  factory Option.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Option(
      expirationDate:
          DateTime.fromMillisecondsSinceEpoch(map['expirationDate']),
      strikePrice: map['strikePrice'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Option.fromJson(String source) => Option.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Option(expirationDate: $expirationDate, strikePrice: $strikePrice, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Option &&
        o.expirationDate == expirationDate &&
        o.strikePrice == strikePrice &&
        o.quantity == quantity &&
        o.price == price;
  }

  @override
  int get hashCode {
    return expirationDate.hashCode ^
        strikePrice.hashCode ^
        quantity.hashCode ^
        price.hashCode;
  }

  String get positionHash {
    DateFormat formatter = DateFormat(
        '${DateFormat.YEAR}-${DateFormat.ABBR_MONTH}-${DateFormat.DAY}');
    return '${formatter.format(expirationDate)}-$strikePrice';
  }
}
