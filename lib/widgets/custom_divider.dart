// lib/widgets/custom_divider.dart
import 'package:basketball_counter_app/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final Color color;

  const CustomDivider({
    super.key,
    required this.height,
    this.color = dividerColor,
  });

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
