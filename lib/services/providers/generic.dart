import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/classes/generic.dart';

final productFilterProvider =
    StateNotifierProvider<ProductFilterNotifier, String>((ref) {
  return ProductFilterNotifier();
});

final pageProvider = StateNotifierProvider<PageNotifier, int>((ref) {
  return PageNotifier();
});

final screenProvider = StateNotifierProvider<ScreenNotifier, Widget>((ref) {
  return ScreenNotifier();
});
