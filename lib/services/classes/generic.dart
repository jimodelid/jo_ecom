import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/pages/homepage.dart';

class ProductFilterNotifier extends StateNotifier<String> {
  ProductFilterNotifier() : super('');

  void setProductFilter(searchValue) {
    state = searchValue;
  }
}

class ScreenNotifier extends StateNotifier<Widget> {
  ScreenNotifier() : super(const HomePage());

  void setScreen(screen) {
    state = screen;
  }
}

class PageNotifier extends StateNotifier<int> {
  PageNotifier() : super(0);

  void setPage(page) {
    state = page;
  }
}
