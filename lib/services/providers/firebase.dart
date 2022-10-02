import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/classes/firebase.dart';
import 'package:jo_ecom/services/models/categorymodel.dart';
import 'package:jo_ecom/services/models/productmodel.dart';
import 'package:jo_ecom/services/models/usermodel.dart';
import 'package:jo_ecom/services/providers/category.dart';

final databaseProvider = Provider<FirestoreDatabase?>((ref) {
  return FirestoreDatabase();
});

final userStreamProvider = StreamProvider.autoDispose<List<UserModel>>((ref) {
  final database = ref.watch(databaseProvider)!;
  final id = FirebaseAuth.instance.currentUser?.uid ?? '';
  return database.userStream(id: id);
});

final productsStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  final activeCategory = ref.watch(categoryProvider);
  final database = ref.watch(databaseProvider)!;
  return database.productsStreamInCategory(activeCategory, ref);
});

final searchStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  final database = ref.watch(databaseProvider)!;
  return database.productsStream(ref);
});

final categoriesStreamProvider =
    StreamProvider.autoDispose<List<Category>>((ref) {
  final database = ref.watch(databaseProvider)!;
  return database.categoriesStream(ref);
});
