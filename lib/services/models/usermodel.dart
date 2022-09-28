class UserModel {
  final String id;
  final String email;
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
    this.name,
    this.image,
    this.address,
    this.zip,
    this.area,
    this.country,
    this.likes,
  });
}
