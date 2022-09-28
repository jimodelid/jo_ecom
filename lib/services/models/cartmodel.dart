import 'package:flutter/foundation.dart';

@immutable
class Cart {
  final String id;
  final String name;
  final String image;
  final String price;
  final int stock;
  final int productStock;

  const Cart({
    required this.id,
    required this.name,
    required this.image,
    required this.stock,
    required this.price,
    required this.productStock,
  });

  factory Cart.fromFirestore(Map<String, dynamic> json) {
    return Cart(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        stock: json['stock'],
        price: json['price'],
        productStock: json['productStock']);
  }

  Cart copyWith({
    String? id,
    String? name,
    String? image,
    String? price,
    int? stock,
    int? productStock,
  }) {
    return Cart(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      productStock: productStock ?? this.productStock,
    );
  }
}
