// lib/widgets/reset_button.dart
import 'package:basketball_counter_app/constant/colors.dart';
import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback onReset;

  const ResetButton({
    super.key,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onReset,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.015,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Reset Scores",
          style: TextStyle(
            color: buttonTextColor,
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.045,
          ),
        ),
      ),
    );
  }
}
