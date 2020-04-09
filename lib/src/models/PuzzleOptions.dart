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
}
