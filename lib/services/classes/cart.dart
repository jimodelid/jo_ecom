import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:jo_ecom/services/models/cartmodel.dart';

class CartNotifier extends StateNotifier<List<Cart>> {
  CartNotifier() : super([]);

  void addCartItem(Cart cartItem, BuildContext context) {
    if (state.where((item) => item.id == cartItem.id).isNotEmpty) {
      final cartStock =
          state.where((item) => item.id == cartItem.id).first.stock;
      if (cartItem.productStock <= cartStock) {
        Get.snackbar(
          'Information',
          'Unable to add more items to cart due to stock shortage.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        increaseQuantity(cartItem.id, context);

        Get.snackbar(
          'Success',
          'Item added to cart.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      state = [...state, cartItem];
      Get.snackbar(
        'Success',
        'Item added to cart.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeCartItem(String cartItemID) {
    state = [
      for (final cartItem in state)
        if (cartItem.id != cartItemID) cartItem,
    ];
  }

  void increaseQuantity(String cartItemID, BuildContext context) {
    state = [
      for (final cartItem in state)
        if (cartItem.id == cartItemID)
          if (cartItem.productStock <= cartItem.stock)
            cartItem.copyWith(stock: cartItem.stock)
          else
            cartItem.copyWith(stock: cartItem.stock + 1)
        else
          cartItem
    ];
  }

  void decreaseQuantity(String cartItemID) {
    state = [
      for (final cartItem in state)
        if (cartItem.id == cartItemID)
          if (cartItem.stock == 1)
            cartItem.copyWith(stock: 1)
          else
            cartItem.copyWith(stock: cartItem.stock - 1)
        else
          cartItem
    ];
  }
}
