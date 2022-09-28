import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/models/productmodel.dart';
import 'package:jo_ecom/services/providers/category.dart';
import 'package:jo_ecom/services/classes/firebase.dart';
import 'package:jo_ecom/widgets/productwidgets/productcardwidget.dart';

final databaseProvider = Provider<FirestoreDatabase?>((ref) {
  return FirestoreDatabase();
});

final productsStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  final activeCategory = ref.watch(categoryProvider);
  final database = ref.watch(databaseProvider)!;
  return database.productsStreamInCategory(activeCategory, ref);
});

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
      error: (error, stackTrace) => Text('$stackTrace'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
