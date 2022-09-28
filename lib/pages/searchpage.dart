import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/classes/firebase.dart';
import 'package:jo_ecom/services/providers/generic.dart';
import 'package:jo_ecom/services/models/productmodel.dart';
import 'package:jo_ecom/widgets/genericwidgets/dividerwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/menuwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/titlewidget.dart';
import 'package:jo_ecom/widgets/searchwidgets/searchresultcard.dart';

final databaseProvider = Provider<FirestoreDatabase?>((ref) {
  return FirestoreDatabase();
});

final productsStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  final database = ref.watch(databaseProvider)!;
  return database.productsStream(ref);
});

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productsStream = ref.watch(productsStreamProvider);
    var searchQuery = ref.watch(productFilterProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 24.0, right: 20, left: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MenuWidget(),
          const HorizontalDividerWidget(),
          const TitleWidget(title: 'Products', subtitle: 'Search our'),
          const HorizontalDividerWidget(),
          TextFormField(
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
              label: const Text('Search products'),
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
                borderSide:
                    const BorderSide(width: 1, color: Colors.lightGreenAccent),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: productsStream.when(
              data: (data) => ListView.builder(
                scrollDirection: Axis.vertical,
                //shrinkWrap: true,
                reverse: false,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = data[index];
                  return SearchResultCard(
                    product: product,
                  );
                },
              ),
              error: (error, stackTrace) => Text('$stackTrace'),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
