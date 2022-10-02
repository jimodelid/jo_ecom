import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductFilterNotifier extends StateNotifier<String> {
  ProductFilterNotifier() : super('');

  void setProductFilter(searchValue) {
    state = searchValue;
  }
}

class PageNotifier extends StateNotifier<int> {
  PageNotifier() : super(0);

  void setPage(page) {
    state = page;
  }
}
