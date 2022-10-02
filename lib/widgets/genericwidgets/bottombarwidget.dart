import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/providers/generic.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
    final index = ref.watch(pageProvider);

    return CurvedNavigationBar(
      key: bottomNavigationKey,
      index: index,
      height: 60.0,
      items: const <Widget>[
        Icon(color: Colors.black54, EvaIcons.homeOutline, size: 24),
        Icon(color: Colors.black54, EvaIcons.searchOutline, size: 24),
        Icon(color: Colors.black54, EvaIcons.shoppingCartOutline, size: 24),
        Icon(color: Colors.black54, EvaIcons.heartOutline, size: 24),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) {
        ref.read(pageProvider.notifier).setPage(index);
      },
      letIndexChange: (index) => true,
    );
  }
}
