import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/classes/firebase.dart';
import 'package:jo_ecom/services/models/categorymodel.dart';
import 'package:jo_ecom/services/models/productmodel.dart';
import 'package:jo_ecom/services/models/usermodel.dart';
import 'package:jo_ecom/services/providers/auth.dart';
import 'package:jo_ecom/services/providers/category.dart';

final databaseProvider = Provider<FirestoreDatabase?>((ref) {
  return FirestoreDatabase();
});

final userStreamProvider = StreamProvider<List<UserModel>>((ref) {
  final database = ref.watch(databaseProvider)!;
  final userIdProvider = ref.watch(authStateProvider);
  final userID = userIdProvider.value?.uid ?? '';

  return database.userStream(id: userID);
});

final productsStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  final activeCategory = ref.watch(categoryProvider);
  final database = ref.watch(databaseProvider)!;
  return database.productsStreamInCategory(activeCategory, ref);
});

final multipleProductsStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final user = ref.watch(userStreamProvider);
  final likes = user.value?.first.likes ?? [];
  final database = ref.watch(databaseProvider)!;
  return database.multipleProductsStream(ref, likes);
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
