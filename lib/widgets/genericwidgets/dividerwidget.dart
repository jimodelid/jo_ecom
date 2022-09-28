import 'package:flutter/material.dart';

class HorizontalDividerWidget extends StatelessWidget {
  const HorizontalDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 30);
  }
}

class VerticalDividerWidget extends StatelessWidget {
  const VerticalDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 30);
  }
}
