import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryNotifier extends StateNotifier<String> {
  CategoryNotifier() : super('');

  void setCategory(categoryID) {
    state = categoryID;
  }
}
