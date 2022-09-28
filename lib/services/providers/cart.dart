import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/models/cartmodel.dart';
import 'package:jo_ecom/services/classes/cart.dart';

final cartItemsProvider =
    StateNotifierProvider<CartNotifier, List<Cart>>((ref) {
  return CartNotifier();
});
