import 'package:flutter/material.dart';

class CustomVerticalDevider extends StatelessWidget {
  const CustomVerticalDevider(
      {super.key, required this.height, required this.color});
  final double height;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: VerticalDivider(
        thickness: 0.3,
        color: color,
      ),
    );
  }
}
