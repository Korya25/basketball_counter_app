// Counter Cubit
import 'package:basketball_counter_app/cubits/countir_state.dart';
import 'package:basketball_counter_app/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(InitialScoreState());

  int teamAScore = 0;
  int teamBScore = 0;
  String teamAName = 'Team A';
  String teamBName = 'Team B';
  List<String> scoreHistory = [];

  void addScore(String team, int points) {
    if (team == teamAName) {
      teamAScore = (teamAScore + points).clamp(0, double.infinity).toInt();
    } else {
      teamBScore = (teamBScore + points).clamp(0, double.infinity).toInt();
    }

    String timestamp = DateFormat('hh:mm:ss a').format(DateTime.now());
    String change = points > 0 ? "+$points" : "$points";
    scoreHistory.add("[$timestamp] $team: $change points");
    emit(AddScoreState());
  }

  void minusScore(String team, int points) {
    if (teamAScore != 0 || teamBScore != 0) {
      if (team == teamAName) {
        teamAScore = (teamAScore + points).clamp(0, double.infinity).toInt();
      } else {
        teamBScore = (teamBScore + points).clamp(0, double.infinity).toInt();
      }

      String timestamp = DateFormat('hh:mm:ss a').format(DateTime.now());
      String change = points > 0 ? "+$points" : "$points";
      scoreHistory.add("[$timestamp] $team: $change points");
      emit(AddScoreState());
    } else {
      emit(AlertMessageState());
    }
  }

  void resetScores(BuildContext context) {
    if (teamAScore != 0 || teamBScore != 0) {
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
          teamAScore = 0;
          teamBScore = 0;
          scoreHistory.add(
            "[${DateFormat('hh:mm:ss a').format(DateTime.now())}] Scores reset to 0.",
          );
          emit(ResetScoreState());
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
        agreeTap: () {
          Navigator.pop(context);
        },
      );
    }
  }

  void editTeamName(BuildContext context, String team) {
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
            hintText: team,
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
              if (team == teamAName) {
                teamAName =
                    controller.text.isEmpty ? teamAName : controller.text;
              } else {
                teamBName =
                    controller.text.isEmpty ? teamBName : controller.text;
              }
              emit(TeamNameState());
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
}
