import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jo_ecom/pages/cartpage.dart';
import 'package:jo_ecom/pages/favoritespage.dart';
import 'package:jo_ecom/pages/homepage.dart';
import 'package:jo_ecom/pages/searchpage.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int index = 0;

  final pages = [
    const HomePage(),
    const SearchPage(),
    const CartPage(),
    const FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[index],
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        index: index,
        height: 60.0,
        items: const <Widget>[
          Icon(color: Colors.black54, Icons.home_outlined, size: 24),
          Icon(color: Colors.black54, Icons.search_outlined, size: 24),
          Icon(color: Colors.black54, Icons.shopping_cart_outlined, size: 24),
          Icon(color: Colors.black54, Icons.favorite_outlined, size: 24),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) => setState(() {
          this.index = index;
        }),
        letIndexChange: (index) => true,
      ),
    );
  }
}
