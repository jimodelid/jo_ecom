import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:jo_ecom/services/providers/firebase.dart';
import 'package:jo_ecom/widgets/genericwidgets/menuwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/titlewidget.dart';
import 'package:jo_ecom/widgets/searchwidgets/searchresultcard.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(userStreamProvider);
    final productsStream = ref.watch(multipleProductsStreamProvider);

    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MenuWidget(),
            const SizedBox(height: 30),
            const TitleWidget(title: 'Likes', subtitle: 'View your'),
            const SizedBox(height: 10),
            userStream.when(
              data: (data) {
                if (data.isNotEmpty) {
                  final likes = data.first.likes;
                  if (likes!.isNotEmpty) {
                    return productsStream.when(
                      data: (data) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          reverse: false,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final product = data[index];
                            return SearchResultCard(
                              product: product,
                            );
                          },
                        );
                      },
                      error: (error, stackTrace) => Text('$error'),
                      loading: () => const CircularProgressIndicator(),
                    );
                  } else {
                    return const Text(
                        'Woops.. =(\nSeems like you don\'t have any liked products yet.');
                  }
                } else {
                  return const Text(
                      'Woops.. =(\nSeems like you\'re not signed in.\nPlease sign in to view your likes.');
                }
              },
              error: (e, trace) {
                Get.snackbar(
                  'Error',
                  e.toString(),
                  snackPosition: SnackPosition.BOTTOM,
                );
                return const SizedBox();
              },
              loading: () => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
