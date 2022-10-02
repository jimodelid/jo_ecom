import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final Timestamp createdAt;
  String? name;
  String? image;
  String? address;
  String? zip;
  String? area;
  String? country;
  List? likes;

  UserModel({
    required this.id,
    required this.email,
    required this.createdAt,
    this.name,
    this.image,
    this.address,
    this.zip,
    this.area,
    this.country,
    this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'createdAt': createdAt,
      'name': name,
      'image': image,
      'address': address,
      'zip': zip,
      'area': area,
      'country': country,
      'likes': likes,
    };
  }

  factory UserModel.fromFirestore(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      createdAt: json['createdAt'],
      name: json['name'],
      image: json['image'],
      address: json['address'],
      zip: json['zip'],
      area: json['area'],
      country: json['country'],
      likes: json['likes'],
    );
  }
}
