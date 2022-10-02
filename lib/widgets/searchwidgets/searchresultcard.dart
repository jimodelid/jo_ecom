import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/models/productmodel.dart';
import 'package:jo_ecom/pages/productpage.dart';
import 'package:jo_ecom/services/models/usermodel.dart';
import 'package:jo_ecom/services/providers/firebase.dart';
import 'package:jo_ecom/widgets/genericwidgets/toastwidget.dart';
import 'package:page_transition/page_transition.dart';

class SearchResultCard extends ConsumerWidget {
  const SearchResultCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userStream = ref.watch(userStreamProvider);

    return Stack(
      children: [
        Card(
          elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: ProductPage(
                    product: product,
                  ),
                  type: PageTransitionType.rotate,
                  alignment: Alignment.topCenter,
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100), // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(60), // Image radius
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          product.summary,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '\$${product.price}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        userStream.when(
            data: (data) {
              if (data.isNotEmpty) {
                final user = data.first;
                final likes = user.likes;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (user.id.isEmpty) {
                          toast(context,
                              'You need to be signed in to add a product to your likes list.');
                        } else {
                          final userInfo = UserModel(
                              id: user.id,
                              email: user.email,
                              createdAt: user.createdAt,
                              name: user.name,
                              address: user.address,
                              zip: user.zip,
                              area: user.area,
                              country: user.country,
                              likes: likes.contains(product.id)
                                  ? [
                                      for (final like in user.likes!)
                                        if (like != product.id) like,
                                    ]
                                  : [...?user.likes, product.id]);

                          ref
                              .read(databaseProvider)!
                              .updateUser(userInfo, context);
                        }
                      },
                      icon: likes!.contains(product.id)
                          ? const Icon(
                              EvaIcons.heart,
                              color: Colors.redAccent,
                            )
                          : const Icon(
                              EvaIcons.heartOutline,
                              color: Colors.redAccent,
                            ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
            error: (e, trace) => SizedBox(child: Text(e.toString())),
            loading: () => const CircularProgressIndicator()),
      ],
    );
  }
}
