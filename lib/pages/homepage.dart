import 'package:flutter/material.dart';
import 'package:jo_ecom/widgets/categorywidgets/categorywidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/menuwidget.dart';
import 'package:jo_ecom/widgets/productwidgets/productwidget.dart';
import 'package:jo_ecom/widgets/searchwidgets/searchwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/titlewidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MenuWidget(),
            SizedBox(height: 30),
            TitleWidget(title: 'Products', subtitle: 'Our'),
            SizedBox(height: 30),
            SearchWidget(),
            SizedBox(height: 30),
            CategoryWidget(),
            SizedBox(height: 30),
            ProductWidget(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
