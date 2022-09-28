import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jo_ecom/services/models/categorymodel.dart';
import 'package:jo_ecom/services/models/productmodel.dart';
import 'package:jo_ecom/services/providers/category.dart';
import 'package:jo_ecom/services/providers/generic.dart';
import 'package:jo_ecom/widgets/genericwidgets/toastwidget.dart';

class FirestorePath {
  static String product(String productId) => 'products/$productId';
  static String products() => 'products';
  static String category(String categoryId) => 'categories/$categoryId';
  static String categories() => 'categories';
  static String cart() => 'carts';
}

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      await toast(context, e.toString());
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      await toast(context, e.toString());
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}

class FirestoreDatabase {
  //Future<void> setJob(Job job) { ... }
  //Future<void> deleteJob(Job job) { ... }
  Stream<Category> categoryStream({required String categoryId}) {
    Stream<Category> categoryStream = FirebaseFirestore.instance
        .collection(FirestorePath.category(categoryId))
        .where('visible', isEqualTo: true)
        .orderBy('createdAt', descending: false)
        .snapshots() as Stream<Category>;

    return categoryStream;
  }

  Stream<List<Category>> categoriesStream(ref) {
    late Stream<List<Category>> stream;
    String activeCategory = ref.watch(categoryProvider);

    final Query query =
        FirebaseFirestore.instance.collection(FirestorePath.categories());
    final Stream<QuerySnapshot> snapshots = query.snapshots();

    stream = snapshots.map(
      (snapshot) {
        var result = snapshot.docs
            .map((element) =>
                Category.fromFirestore(element.data() as Map<String, dynamic>))
            .toList();

        if (activeCategory.isEmpty) {
          ref.read(categoryProvider.notifier).setCategory(result.last.id);
        }

        return result;
      },
    );

    return stream;
  }

  Stream<Product> productStream({required String productId}) {
    Stream<Product> productStream = FirebaseFirestore.instance
        .collection(FirestorePath.category(productId))
        .where('id', isEqualTo: productId)
        .snapshots() as Stream<Product>;

    return productStream;
  }

  Stream<List<Product>> productsStreamInCategory(String category, ref) {
    late Stream<List<Product>> stream;
    String searchValue = ref.watch(productFilterProvider);

    final Query query = FirebaseFirestore.instance
        .collection(FirestorePath.products())
        .where('category', isEqualTo: category);
    final Stream<QuerySnapshot> snapshots = query.snapshots();

    stream = snapshots.map(
      (snapshot) {
        var result = snapshot.docs
            .map(
              (products) => Product.fromFirestore(
                products.data() as Map<String, dynamic>,
              ),
            )
            .toList();

        if (searchValue.isNotEmpty) {
          final suggestions = result.where((prod) {
            final productName = prod.name.toLowerCase();
            final input = searchValue.toLowerCase();

            return productName.contains(input);
          }).toList();

          result = suggestions;
        }

        return result;
      },
    );

    return stream;
  }

  Stream<List<Product>> productsStream(ref) {
    late Stream<List<Product>> stream;
    String searchValue = ref.watch(productFilterProvider);

    final Query query = FirebaseFirestore.instance.collection(
      FirestorePath.products(),
    );

    final Stream<QuerySnapshot> snapshots = query.snapshots();

    stream = snapshots.map(
      (snapshot) {
        var result = snapshot.docs
            .map(
              (products) => Product.fromFirestore(
                products.data() as Map<String, dynamic>,
              ),
            )
            .toList();

        if (searchValue.isNotEmpty) {
          final suggestions = result.where((prod) {
            final productName = prod.name.toLowerCase();
            final input = searchValue.toLowerCase();

            return productName.contains(input);
          }).toList();

          result = suggestions;
        }

        return result;
      },
    );

    return stream;
  }
}
