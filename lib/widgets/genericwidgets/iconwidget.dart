import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({super.key, required this.icon, this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        overlayColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
        onTap: () => Scaffold.of(context).openDrawer(),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
