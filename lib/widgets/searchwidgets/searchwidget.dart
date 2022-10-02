import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/providers/generic.dart';
import 'package:jo_ecom/widgets/genericwidgets/iconwidget.dart';

class SearchWidget extends ConsumerWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchQuery = ref.watch(productFilterProvider);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Card(
            child: TextFormField(
              initialValue: searchQuery,
              onChanged: (value) => ref
                  .read(productFilterProvider.notifier)
                  .setProductFilter(value),
              style: const TextStyle(
                fontSize: 14.0,
                height: 1.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(EvaIcons.searchOutline),
                prefixIconColor: Colors.black87,
                filled: true,
                fillColor: const Color.fromARGB(248, 235, 235, 235),
                label: const Text('Search products in category'),
                labelStyle: const TextStyle(color: Colors.black),
                contentPadding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                enabledBorder: OutlineInputBorder(
                  gapPadding: 2,
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color.fromARGB(248, 228, 228, 228),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      width: 1, color: Colors.lightGreenAccent),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 26),
        const IconWidget(icon: EvaIcons.options2Outline)
      ],
    );
  }
}
