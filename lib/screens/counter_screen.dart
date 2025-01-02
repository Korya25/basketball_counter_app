import 'package:basketball_counter_app/constant/colors.dart';
import 'package:basketball_counter_app/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int teamAScore = 0;
  int teamBScore = 0;
  String teamAName = 'Team A';
  String teamBName = 'Team B';

  // List to store the history of score changes
  List<String> scoreHistory = [];

  void updateScore(String team, int points) {
    setState(() {
      if (team == teamAName) {
        teamAScore = (teamAScore + points).clamp(0, double.infinity).toInt();
      } else {
        teamBScore = (teamBScore + points).clamp(0, double.infinity).toInt();
      }

      // Record the change in the history
      String timestamp = DateFormat('hh:mm:ss a').format(DateTime.now());
      String change = points > 0 ? "+$points" : "$points";
      scoreHistory.add("[$timestamp] $team: $change points");
    });
  }

  void miunsScore(String team, int points) {
    setState(() {
      if (teamAScore != 0 || teamBScore != 0) {
        if (team == teamAName) {
          teamAScore = (teamAScore + points).clamp(0, double.infinity).toInt();
        } else {
          teamBScore = (teamBScore + points).clamp(0, double.infinity).toInt();
        }
        // Record the change in the history
        String timestamp = DateFormat('hh:mm:ss a').format(DateTime.now());
        String change = points > 0 ? "+$points" : "$points";
        scoreHistory.add("[$timestamp] $team: $change points");
      }
    });
  }

  void editTeamName(String team) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 53, 52, 52),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          "Edit Name",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: SingleChildScrollView(
          child: TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: team,
              hintStyle: const TextStyle(color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                if (team == teamAName) {
                  teamAName =
                      controller.text.isEmpty ? teamAName : controller.text;
                } else {
                  teamBName =
                      controller.text.isEmpty ? teamBName : controller.text;
                }
              });
              Navigator.pop(context);
            },
            child: const Text(
              "Save",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resetScores() {
    if (teamAScore != 0 || teamBScore != 0) {
      CustomDialogHandler.showCustomDialog(
        height: 70,
        context,
        "Are you sure you want to reset the scores?",
        backgroundColor: const Color.fromARGB(255, 53, 52, 52),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        buttontextStyle: TextStyle(
          color: Colors.blue,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        cancelTap: () => Navigator.pop(context),
        agreeName: 'Reset',
        enableCancelButton: true,
        agreeTap: () {
          setState(() {
            teamAScore = 0;
            teamBScore = 0;
            scoreHistory.add(
                "[${DateFormat('hh:mm:ss a').format(DateTime.now())}] Scores reset to 0.");
          });
          Navigator.pop(context);
        },
      );
    } else {
      CustomDialogHandler.showCustomDialog(
        height: 50,
        backgroundColor: const Color.fromARGB(255, 53, 52, 52),
        context,
        "No points to remove",
        buttontextStyle: TextStyle(
          color: Colors.blue,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        agreeTap: () {
          Navigator.pop(context);
        },
      );
    }
  }

  void showHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Score History"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: scoreHistory
                .map((event) => Text(
                      event,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

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
            onPressed: showHistory,
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
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTeamSection(size, teamAName, teamAScore),
                    buildVerticalDivider(height: size.height * 0.5),
                    buildTeamSection(size, teamBName, teamBScore),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                buildResetButton(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTeamSection(Size size, String teamName, int score) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              teamName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                editTeamName(teamName);
              },
              child: Icon(
                Icons.edit,
                color: Colors.black12,
                size: size.width * 0.05,
              ),
            ),
          ],
        ),
        Text(
          '$score',
          style: TextStyle(
            fontSize: size.width * 0.25,
            fontWeight: FontWeight.bold,
            color: scoreTextColor,
          ),
        ),
        Column(
          children: [
            buildPointControl(size, '1 Point', teamName, 1),
            SizedBox(height: size.height * 0.02),
            buildPointControl(size, '2 Points', teamName, 2),
            SizedBox(height: size.height * 0.02),
            buildPointControl(size, '3 Points', teamName, 3),
          ],
        ),
      ],
    );
  }

  Widget buildPointControl(Size size, String title, String team, int points) {
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
                onPressed: () => updateScore(team, points),
                icon: Icon(
                  Icons.add_circle,
                  color: addIconColor,
                  size: size.width * 0.08,
                ),
              ),
              buildVerticalDivider(height: size.height * 0.03),
              IconButton(
                onPressed: () => miunsScore(team, -points),
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

  Widget buildResetButton(Size size) {
    return GestureDetector(
      onTap: resetScores,
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

  Widget buildVerticalDivider(
      {required double height, Color color = dividerColor}) {
    return SizedBox(
      height: height,
      child: VerticalDivider(
        thickness: 0.3,
        color: color,
      ),
    );
  }
}
