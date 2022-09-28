import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;
  final String image;
  final bool visible;
  final Timestamp createdAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.visible,
    required this.createdAt,
  });

  factory Category.fromFirestore(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      visible: json['visible'],
      createdAt: json['createdAt'],
    );
  }
}
