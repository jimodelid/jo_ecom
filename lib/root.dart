import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/pages/cartpage.dart';
import 'package:jo_ecom/pages/favoritespage.dart';
import 'package:jo_ecom/pages/homepage.dart';
import 'package:jo_ecom/pages/searchpage.dart';
import 'package:jo_ecom/services/providers/firebase.dart';

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
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: const NavDrawer(),
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

class NavDrawer extends ConsumerWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesStreamProvider);

    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 1,
            child: categories.when(
              data: (data) {
                if (data.isNotEmpty) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    reverse: false,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final cateogry = data[index];
                      return ListTile(
                        leading: Image.network(cateogry.image),
                        title: Text(cateogry.name),
                        onTap: () {},
                      );
                    },
                  );
                } else {
                  return const Text('No categories found..');
                }
              },
              error: (error, stackTrace) => Text('$error'),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );

    /*ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Drawer Header',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Item 1'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Item 2'),
          onTap: () {},
        ),
      ],
    );*/
  }
}
