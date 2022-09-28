import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/models/categorymodel.dart';
import 'package:jo_ecom/services/classes/firebase.dart';
import 'package:jo_ecom/widgets/categorywidgets/categorycardwidget.dart';

final databaseProvider = Provider<FirestoreDatabase?>((ref) {
  return FirestoreDatabase();
});

final categoriesStreamProvider =
    StreamProvider.autoDispose<List<Category>>((ref) {
  final database = ref.watch(databaseProvider)!;
  return database.categoriesStream(ref);
});

class CategoryWidget extends ConsumerWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesStream = ref.watch(categoriesStreamProvider);

    return categoriesStream.when(
      data: (data) => SizedBox(
        height: 65,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          reverse: true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            final category = data[index];
            return CategoryCard(
              id: category.id,
              name: category.name,
              image: category.image,
            );
          },
        ),
      ),
      error: (error, stackTrace) => Text('$error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
