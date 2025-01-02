// lib/services/score_service.dart
import 'package:flutter/material.dart';
import '../models/team.dart';
import '../models/score_event.dart';
import '../utils/custom_dialog.dart';

class ScoreService {
  final Team teamA = Team(name: 'Team A');
  final Team teamB = Team(name: 'Team B');
  final List<ScoreEvent> scoreHistory = [];

  void updateScore(String teamName, int points) {
    if ((teamName == teamA.name && teamA.score + points >= 0) ||
        (teamName == teamB.name && teamB.score + points >= 0)) {
      if (teamName == teamA.name) {
        teamA.updateScore(points);
      } else {
        teamB.updateScore(points);
      }

      scoreHistory.add(ScoreEvent(
        timestamp: DateTime.now(),
        teamName: teamName,
        points: points,
        type: "update",
      ));
    }
  }

  void editTeamName(BuildContext context, String currentName) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 53, 52, 52),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text(
          "Edit Name",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: TextField(
          style: const TextStyle(color: Colors.white),
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: currentName,
            hintStyle: const TextStyle(color: Colors.grey),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              final newName = controller.text;
              if (newName.isNotEmpty) {
                if (currentName == teamA.name) {
                  teamA.name = newName;
                } else {
                  teamB.name = newName;
                }
              }
              Navigator.pop(context);
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  void resetScores(BuildContext context) {
    if (teamA.score != 0 || teamB.score != 0) {
      CustomDialogHandler.showCustomDialog(
        height: 70,
        context,
        "Are you sure you want to reset the scores?",
        backgroundColor: const Color.fromARGB(255, 53, 52, 52),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        buttontextStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        cancelTap: () => Navigator.pop(context),
        agreeName: 'Reset',
        enableCancelButton: true,
        agreeTap: () {
          teamA.resetScore();
          teamB.resetScore();
          scoreHistory.add(ScoreEvent(
            timestamp: DateTime.now(),
            teamName: "",
            points: 0,
            type: "reset",
          ));
          Navigator.pop(context);
        },
      );
    } else {
      CustomDialogHandler.showCustomDialog(
        height: 50,
        backgroundColor: const Color.fromARGB(255, 53, 52, 52),
        context,
        "No points to remove",
        buttontextStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        agreeTap: () => Navigator.pop(context),
      );
    }
  }

  void showHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Score History"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: scoreHistory
                .map((event) => Text(
                      event.toString(),
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
}
