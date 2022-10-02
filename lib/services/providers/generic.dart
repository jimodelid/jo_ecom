import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/classes/generic.dart';

final productFilterProvider =
    StateNotifierProvider<ProductFilterNotifier, String>((ref) {
  return ProductFilterNotifier();
});

final pageProvider = StateNotifierProvider<PageNotifier, int>((ref) {
  return PageNotifier();
});
