import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/models/cartmodel.dart';
import 'package:jo_ecom/widgets/genericwidgets/toastwidget.dart';

class CartNotifier extends StateNotifier<List<Cart>> {
  CartNotifier() : super([]);

  void addCartItem(Cart cartItem, BuildContext context) {
    if (state.where((item) => item.id == cartItem.id).isNotEmpty) {
      final cartStock =
          state.where((item) => item.id == cartItem.id).first.stock;
      if (cartItem.productStock <= cartStock) {
        toast(
            context, 'Unable to add more items to cart due to stock shortage.');
      } else {
        increaseQuantity(cartItem.id, context);
        toast(context, 'Item added to cart.');
      }
    } else {
      state = [...state, cartItem];
      toast(context, 'Item added to cart.');
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
