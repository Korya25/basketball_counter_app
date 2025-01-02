// lib/widgets/team_section.dart
import 'package:basketball_counter_app/constant/colors.dart';
import 'package:flutter/material.dart';
import '../models/team.dart';
import 'point_control.dart';

class TeamSection extends StatelessWidget {
  final Team team;
  final Function(String, int) onScoreUpdate;
  final Function(String) onNameEdit;

  const TeamSection({
    super.key,
    required this.team,
    required this.onScoreUpdate,
    required this.onNameEdit,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              team.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            GestureDetector(
              onTap: () => onNameEdit(team.name),
              child: Icon(
                Icons.edit,
                color: Colors.black12,
                size: size.width * 0.05,
              ),
            ),
          ],
        ),
        Text(
          '${team.score}',
          style: TextStyle(
            fontSize: size.width * 0.25,
            fontWeight: FontWeight.bold,
            color: scoreTextColor,
          ),
        ),
        Column(
          children: [
            PointControl(
              title: '1 Point',
              team: team.name,
              points: 1,
              onScoreUpdate: onScoreUpdate,
            ),
            SizedBox(height: size.height * 0.02),
            PointControl(
              title: '2 Points',
              team: team.name,
              points: 2,
              onScoreUpdate: onScoreUpdate,
            ),
            SizedBox(height: size.height * 0.02),
            PointControl(
              title: '3 Points',
              team: team.name,
              points: 3,
              onScoreUpdate: onScoreUpdate,
            ),
          ],
        ),
      ],
    );
  }
}
