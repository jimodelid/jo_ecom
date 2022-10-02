import 'package:flutter/material.dart';

class VerticalSpacerWidget extends StatelessWidget {
  const VerticalSpacerWidget({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HorizontalSpacerWidget extends StatelessWidget {
  const HorizontalSpacerWidget({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
