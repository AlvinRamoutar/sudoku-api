
import 'package:uuid/uuid.dart';

class PuzzleOptions {

  final String _id = new Uuid().v1();
  String name;
  int difficulty;
  String patternName;

  PuzzleOptions({String name,
                 int difficulty,
                 String patternName}) {
    this.name = name;
    this.difficulty = (difficulty == null) ? 0 : difficulty;
    this.patternName = (patternName == null || patternName.isEmpty) ?
      "Random" : patternName;
  }

}