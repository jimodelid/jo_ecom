import 'package:flutter/material.dart';
import 'package:jo_ecom/widgets/categorywidgets/categorywidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/spacerwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/menuwidget.dart';
import 'package:jo_ecom/widgets/productwidgets/productwidget.dart';
import 'package:jo_ecom/widgets/searchwidgets/searchwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/titlewidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, right: 20, left: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MenuWidget(),
            VerticalSpacerWidget(height: 30),
            TitleWidget(title: 'Products', subtitle: 'Our'),
            VerticalSpacerWidget(height: 30),
            SearchWidget(),
            VerticalSpacerWidget(height: 30),
            CategoryWidget(),
            VerticalSpacerWidget(height: 30),
            ProductWidget(),
            VerticalSpacerWidget(height: 30),
          ],
        ),
      ),
    );
  }
}
