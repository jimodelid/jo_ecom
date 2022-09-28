import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String image;
  final String description;
  final String summary;
  final String category;
  final bool visible;
  final Timestamp createdAt;
  final String inprice;
  final String price;
  final int stock;

  Product(
      {required this.id,
      required this.name,
      required this.image,
      required this.description,
      required this.summary,
      required this.price,
      required this.inprice,
      required this.category,
      required this.visible,
      required this.createdAt,
      required this.stock});

  factory Product.fromFirestore(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      summary: json['summary'],
      price: json['price'],
      inprice: json['inprice'],
      category: json['category'],
      visible: json['visible'],
      createdAt: json['createdAt'],
      stock: json['stock'],
    );
  }
}
