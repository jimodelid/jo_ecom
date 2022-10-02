import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/pages/cartpage.dart';
import 'package:jo_ecom/pages/favouritespage.dart';
import 'package:jo_ecom/pages/homepage.dart';
import 'package:jo_ecom/pages/searchpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jo_ecom/services/providers/generic.dart';
import 'package:jo_ecom/widgets/genericwidgets/bottombarwidget.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int page = ref.watch(pageProvider);

    final screens = [
      const HomePage(),
      const SearchPage(),
      const CartPage(),
      const FavouritesPage(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.black54,
            ),
      ),
      home: Scaffold(
          bottomNavigationBar: const BottomBar(),
          backgroundColor: const Color.fromARGB(249, 249, 249, 249),
          body: screens[page]),
    );
  }
}
