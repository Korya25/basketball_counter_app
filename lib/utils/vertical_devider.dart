import 'package:basketball_counter_app/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomVerticalDevider extends StatelessWidget {
  const CustomVerticalDevider(
      {super.key, required this.height, this.color = dividerColor});
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
