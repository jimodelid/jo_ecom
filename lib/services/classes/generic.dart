import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductFilterNotifier extends StateNotifier<String> {
  ProductFilterNotifier() : super('');

  void setProductFilter(searchValue) {
    state = searchValue;
  }
}
