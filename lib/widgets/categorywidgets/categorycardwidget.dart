import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/providers/category.dart';

class CategoryCard extends ConsumerWidget {
  const CategoryCard(
      {super.key, required this.id, required this.name, required this.image});

  final String id;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCategory = ref.watch(categoryProvider);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: id == activeCategory ? Colors.lightGreenAccent : Colors.white,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        overlayColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
        onTap: () {
          ref.read(categoryProvider.notifier).setCategory(id);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(16),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }
}
