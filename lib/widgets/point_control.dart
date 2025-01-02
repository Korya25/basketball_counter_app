// lib/widgets/point_control.dart
import 'package:basketball_counter_app/constant/colors.dart';
import 'package:basketball_counter_app/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class PointControl extends StatelessWidget {
  final String title;
  final String team;
  final int points;
  final Function(String, int) onScoreUpdate;

  const PointControl({
    super.key,
    required this.title,
    required this.team,
    required this.points,
    required this.onScoreUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: size.width * 0.035,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => onScoreUpdate(team, points),
                icon: Icon(
                  Icons.add_circle,
                  color: addIconColor,
                  size: size.width * 0.08,
                ),
              ),
              CustomDivider(height: size.height * 0.03),
              IconButton(
                onPressed: () => onScoreUpdate(team, -points),
                icon: Icon(
                  Icons.remove_circle,
                  color: removeIconColor,
                  size: size.width * 0.08,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
