import 'package:uuid/uuid.dart';

import '../Puzzle.dart';

/// Encapsulates serializable properties required for setting up a [Puzzle]
class PuzzleOptions {
  final String _id = new Uuid().v1();
  String name;
  int difficulty;
  String patternName;

  /// Constructs new PuzzleOptions - use me when constructing a new [Puzzle]
  PuzzleOptions(
      {String name, int difficulty = 0, String patternName = "Random"}) {
    this.name = name;
    this.difficulty = difficulty;
    this.patternName = patternName;
  }

  /// Serialization
  ///
  factory PuzzleOptions.fromMap(Map<String, dynamic> json) => PuzzleOptions(
    name: json["name"] == null ? null : json["name"],
    difficulty: json["difficulty"] == null ? null : json["difficulty"],
    patternName: json["pattern_name"] == null ? null : json["pattern_name"],
  );
  Map<String, dynamic> toMap() => {
    "name": name == null ? null : name,
    "difficulty": difficulty == null ? null : difficulty,
    "pattern_name": patternName == null ? null : patternName,
  };


}
