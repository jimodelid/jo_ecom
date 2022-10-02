import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/models/cartmodel.dart';
import 'package:jo_ecom/services/providers/cart.dart';
import 'package:jo_ecom/widgets/cartwidgets/cartitemswidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/spacerwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/menuwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/titlewidget.dart';

class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Cart> cartItems = ref.watch(cartItemsProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 24.0, right: 20, left: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MenuWidget(),
            const VerticalSpacerWidget(height: 30),
            const TitleWidget(title: 'Cart', subtitle: 'Your'),
            const SizedBox(height: 10),
            cartItems.isEmpty
                ? const Text(
                    'Your cart is currently empty.. \nAdd items to your cart in order to view them here and continue to checkout.')
                : CartItem(cartItems: cartItems),
          ],
        ),
      ),
    );
  }
}
