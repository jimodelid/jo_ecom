import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/classes/category.dart';

final categoryProvider = StateNotifierProvider<CategoryNotifier, String>((ref) {
  return CategoryNotifier();
});
