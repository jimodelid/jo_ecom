import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:jo_ecom/pages/profilepage.dart';
import 'package:jo_ecom/root.dart';
import 'package:jo_ecom/services/models/categorymodel.dart';
import 'package:jo_ecom/services/models/productmodel.dart';
import 'package:jo_ecom/services/models/usermodel.dart';
import 'package:jo_ecom/services/providers/category.dart';
import 'package:jo_ecom/services/providers/generic.dart';

class FirestorePath {
  static String product(String productId) => 'products/$productId';
  static String products() => 'products';
  static String category(String categoryId) => 'categories/$categoryId';
  static String categories() => 'categories';
  static String cart() => 'carts';
  static String user(String userId) => 'users/$userId';
  static String users() => 'users';
}

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      Get.snackbar(
        'Success',
        'You\'ve been signed in!',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAll(() => const Root());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signUpWithEmailAndPassword(
    UserModel user,
    String password,
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      auth
          .createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      )
          .then((value) {
        Get.snackbar(
          'Succecss',
          'You\'ve been signed in.',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.to(() => const ProfilePage());
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signOut(context, List<UserModel> user) async {
    await auth.signOut();
    user.clear();
  }
}

class FirestoreDatabase {
  Stream<List<UserModel>> userStream({required String id}) {
    late Stream<List<UserModel>> stream;

    final Query query = FirebaseFirestore.instance
        .collection(FirestorePath.users())
        .where('id', isEqualTo: id);
    final Stream<QuerySnapshot> snapshots = query.snapshots();

    stream = snapshots.map(
      (snapshot) {
        var result = snapshot.docs
            .map((element) =>
                UserModel.fromFirestore(element.data() as Map<String, dynamic>))
            .toList();

        return result;
      },
    );

    return stream;
  }

  Future<void> createUser(UserModel user, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toMap());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateUser(UserModel user, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toMap())
          .then(
            (_) => Get.snackbar(
              'Success',
              'Your information has been updated.',
              snackPosition: SnackPosition.BOTTOM,
            ),
          );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

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

  Stream<List<Product>> multipleProductsStream(ref, List<dynamic> likes) {
    late Stream<List<Product>> stream;

    final Query query = FirebaseFirestore.instance
        .collection(
          FirestorePath.products(),
        )
        .where('id', whereIn: likes);

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

        return result;
      },
    );

    return stream;
  }
}
