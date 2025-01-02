class Team {
  String name;
  int score;

  Team({required this.name, this.score = 0});

  void updateScore(int points) {
    score = (score + points).clamp(0, double.infinity).toInt();
  }

  void resetScore() {
    score = 0;
  }
}
