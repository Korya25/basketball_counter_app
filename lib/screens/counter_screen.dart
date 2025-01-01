import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  // Define a consistent color scheme
  static const Color primaryColor = Color(0xFF4CAF50); // Green
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color dialogBackgroundColor =
      Color(0xFF263238); // Dark grey-blue
  static const Color textColor = Colors.white;
  static const Color scoreTextColor = Colors.black87;
  static const Color buttonTextColor = Colors.white;
  static const Color dividerColor = Colors.grey;
  static const Color addIconColor = Colors.green;
  static const Color removeIconColor = Colors.red;

  // Variables to store scores for each team
  int teamAScore = 0;
  int teamBScore = 0;

  // Increment or decrement the score of the specified team
  void updateScore(String team, int points) {
    setState(() {
      if (team == 'A') {
        teamAScore = (teamAScore + points).clamp(0, double.infinity).toInt();
      } else {
        teamBScore = (teamBScore + points).clamp(0, double.infinity).toInt();
      }
    });
  }

  // Reset scores for both teams
  void resetScores() {
    if (teamAScore != 0 || teamBScore != 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: dialogBackgroundColor,
          content: const Text(
            "Are you sure you want to reset the scores?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close dialog
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  teamAScore = 0;
                  teamBScore = 0;
                });
                Navigator.pop(context); // Reset and close dialog
              },
              child: const Text(
                "Reset",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: dialogBackgroundColor,
          content: const Text(
            "No points to remove",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Basketball Counter',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Row to display scores for both teams
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildTeamSection('Team A', teamAScore, 'A'),
                  buildVerticalDivider(height: 400),
                  buildTeamSection('Team B', teamBScore, 'B'),
                ],
              ),
              const SizedBox(height: 20),

              // Button to reset scores
              buildResetButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the section for a team's score and controls
  Widget buildTeamSection(String teamName, int score, String team) {
    return Column(
      children: [
        // Team name
        Text(
          teamName,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),

        // Team score
        Text(
          '$score',
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              color: scoreTextColor),
        ),

        // Buttons to add or remove points
        Column(
          children: [
            buildPointControl('1 Point', team, 1),
            const SizedBox(height: 16),
            buildPointControl('2 Points', team, 2),
            const SizedBox(height: 16),
            buildPointControl('3 Points', team, 3),
          ],
        ),
      ],
    );
  }

  /// Builds a control to add or remove a specific number of points
  Widget buildPointControl(String title, String team, int points) {
    return Column(
      children: [
        // Point title
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: scoreTextColor,
          ),
        ),
        const SizedBox(height: 8),

        // Row containing add and remove buttons
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add Icon
              IconButton(
                onPressed: () => updateScore(team, points),
                icon: Icon(
                  Icons.add_circle,
                  color: addIconColor,
                  size: 28,
                ),
              ),

              // VerticalDivider
              buildVerticalDivider(height: 30, color: dividerColor),

              // Remove Icon
              IconButton(
                onPressed: () => updateScore(team, -points),
                icon: Icon(
                  Icons.remove_circle,
                  color: removeIconColor,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a vertical divider
  Widget buildVerticalDivider(
      {required double height, Color color = dividerColor}) {
    return SizedBox(
      height: height,
      child: VerticalDivider(
        thickness: 1,
        color: color,
      ),
    );
  }

  /// Builds the reset button to reset scores
  Widget buildResetButton() {
    return GestureDetector(
      onTap: resetScores,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Reset Scores",
          style: TextStyle(
            color: buttonTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
