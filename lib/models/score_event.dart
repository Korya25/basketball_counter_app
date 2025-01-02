// lib/models/score_event.dart
import 'package:intl/intl.dart';

class ScoreEvent {
  final DateTime timestamp;
  final String teamName;
  final int points;
  final String type; // "update", "reset"

  ScoreEvent({
    required this.timestamp,
    required this.teamName,
    required this.points,
    required this.type,
  });

  String get formattedTimestamp => DateFormat('hh:mm:ss a').format(timestamp);

  @override
  String toString() {
    if (type == "reset") {
      return "[$formattedTimestamp] Scores reset to 0.";
    }
    String change = points > 0 ? "+$points" : "$points";
    return "[$formattedTimestamp] $teamName: $change points";
  }
}
