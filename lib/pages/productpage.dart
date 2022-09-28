import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/models/cartmodel.dart';
import 'package:jo_ecom/services/models/productmodel.dart';
import 'package:jo_ecom/services/providers/cart.dart';
import 'package:jo_ecom/widgets/genericwidgets/dividerwidget.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        title: Text(product.name),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreenAccent,
        onPressed: () {
          Cart cartItem = Cart(
            id: product.id,
            name: product.name,
            image: product.image,
            stock: 1,
            price: product.price,
            productStock: product.stock,
          );

          ref.read(cartItemsProvider.notifier).addCartItem(cartItem, context);
        },
        child: const Icon(
          EvaIcons.shoppingCartOutline,
          color: Colors.black87,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
              const HorizontalDividerWidget(),
              const Text('Summary:'),
              Text(product.summary),
              const HorizontalDividerWidget(),
              const Text('Description:'),
              Text(product.description),
              const HorizontalDividerWidget(),
              Text('Price: \$${product.price}'),
              Text('Stock: ${product.stock}'),
            ],
          ),
        ),
      ),
    );
  }
}
