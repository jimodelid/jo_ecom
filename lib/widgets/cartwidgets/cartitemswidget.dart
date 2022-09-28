import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/models/cartmodel.dart';
import 'package:jo_ecom/services/providers/cart.dart';
import 'package:jo_ecom/widgets/genericwidgets/toastwidget.dart';

class CartItem extends ConsumerWidget {
  const CartItem({super.key, required this.cartItems});

  final List<Cart> cartItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems.length,
      itemBuilder: (BuildContext context, int index) {
        final newCartItem = cartItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            contentPadding: const EdgeInsets.all(10),
            tileColor: Colors.white,
            leading: Image.network(
              newCartItem.image,
              fit: BoxFit.cover,
            ),
            title: Text(newCartItem.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price: ${newCartItem.price}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Qty: ${newCartItem.stock}'),
                    const SizedBox(width: 12),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(cartItemsProvider.notifier)
                              .increaseQuantity(newCartItem.id, context);
                        },
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(cartItemsProvider.notifier)
                              .decreaseQuantity(newCartItem.id);
                        },
                        child: const Text(
                          '-',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                ref
                    .read(cartItemsProvider.notifier)
                    .removeCartItem(newCartItem.id);

                toast(context, 'Item removed from cart.');
              },
              icon: const Icon(EvaIcons.trash2Outline),
            ),
          ),
        );
      },
    );
  }
}
