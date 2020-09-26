import 'dart:convert';

import 'Calculable.dart';

class Stock implements Calculable {
  final int quantity;
  final int price;
  Stock({
    this.quantity,
    this.price,
  });

  Stock copyWith({
    int quantity,
    int price,
  }) {
    return Stock(
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'price': price,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Stock(
      quantity: map['quantity'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Stock.fromJson(String source) => Stock.fromMap(json.decode(source));

  @override
  String toString() => 'Stock(quantity: $quantity, price: $price)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Stock && o.quantity == quantity && o.price == price;
  }

  @override
  int get hashCode => quantity.hashCode ^ price.hashCode;
}
