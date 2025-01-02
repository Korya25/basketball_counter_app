// lib/screens/counter_screen.dart
import 'package:basketball_counter_app/constant/colors.dart';
import 'package:basketball_counter_app/widgets/custom_divider.dart';
import 'package:basketball_counter_app/widgets/team_section.dart';
import 'package:flutter/material.dart';
import '../widgets/reset_button.dart';
import '../services/score_service.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final ScoreService _scoreService = ScoreService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.05;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Points Counter',
          style: TextStyle(
            color: textColor,
            fontSize: fontSize + 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _scoreService.showHistory(context),
            icon: const Icon(
              Icons.history,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TeamSection(
                      team: _scoreService.teamA,
                      onScoreUpdate: _updateScore,
                      onNameEdit: (name) =>
                          _scoreService.editTeamName(context, name),
                    ),
                    CustomDivider(height: size.height * 0.5),
                    TeamSection(
                      team: _scoreService.teamB,
                      onScoreUpdate: _updateScore,
                      onNameEdit: (name) =>
                          _scoreService.editTeamName(context, name),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                ResetButton(
                  onReset: () => _scoreService.resetScores(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateScore(String teamName, int points) {
    setState(() {
      _scoreService.updateScore(teamName, points);
    });
  }
}
