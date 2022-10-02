import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/providers/auth.dart';
import 'package:jo_ecom/widgets/genericwidgets/spacerwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/menuwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/titlewidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/toastwidget.dart';

class FavouritesPage extends ConsumerWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, right: 20, left: 20),
        child: authState.when(
          data: (data) {
            if (data != null) {
              return const Text('data');
            } else {
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  MenuWidget(),
                  VerticalSpacerWidget(height: 30),
                  TitleWidget(title: 'Favourites', subtitle: 'Your'),
                  VerticalSpacerWidget(height: 30),
                  Text(
                      'You\'re not signed in.\nPlease sign in to see your favourites.'),
                ],
              );
            }
          },
          error: (e, trace) => toast(context, e.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
