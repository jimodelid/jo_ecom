import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/providers/firebase.dart';
import 'package:jo_ecom/widgets/productwidgets/productcardwidget.dart';

class ProductWidget extends ConsumerWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productsStream = ref.watch(productsStreamProvider);

    return productsStream.when(
      data: (data) => SizedBox(
        height: 325,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          reverse: false,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            final product = data[index];
            return ProductCard(
              product: product,
            );
          },
        ),
      ),
      error: (error, stackTrace) => Text('$error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
