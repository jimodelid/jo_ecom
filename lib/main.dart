import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/pages/cartpage.dart';
import 'package:jo_ecom/pages/favouritespage.dart';
import 'package:jo_ecom/pages/homepage.dart';
import 'package:jo_ecom/pages/searchpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final screens = const [
    HomePage(),
    SearchPage(),
    CartPage(),
    FavouritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.black54,
            ),
      ),
      home: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 60.0,
            items: const <Widget>[
              Icon(color: Colors.black54, EvaIcons.homeOutline, size: 24),
              Icon(color: Colors.black54, EvaIcons.searchOutline, size: 24),
              Icon(
                  color: Colors.black54,
                  EvaIcons.shoppingCartOutline,
                  size: 24),
              Icon(color: Colors.black54, EvaIcons.heartOutline, size: 24),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            letIndexChange: (index) => true,
          ),
          backgroundColor: const Color.fromARGB(249, 249, 249, 249),
          body: screens[_page]),
    );
  }
}
