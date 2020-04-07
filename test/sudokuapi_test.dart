import 'package:flutter_test/flutter_test.dart';
import 'package:sudokuapi/src/Puzzle.dart';
import 'package:sudokuapi/src/logic/GridUtils.dart';
import 'package:sudokuapi/src/models/Position.dart';
import 'package:sudokuapi/src/models/PuzzleOptions.dart';

import 'package:sudokuapi/sudokuapi.dart';

void main() {

  String testTitle01 = 'Test Puzzle Generation. Difficulty: Lv3. Pattern: Random.';
  test(testTitle01, () {
    final PuzzleOptions puzzleOptions = new PuzzleOptions(difficulty: 3);
    final Puzzle puzzle = new Puzzle(puzzleOptions);
    puzzle.generate().then((_) {
      print("=================");
      print(testTitle01);
      print("-----------------");
      printGrid(puzzle.solvedBoard());
      print("-----------------");
      printGrid(puzzle.board());
      print("=================");
    });
  });

  void testPatternPuzzle(String testTitle, String patternName) {
    final PuzzleOptions puzzleOptions =
      new PuzzleOptions(patternName: patternName);
    final Puzzle puzzle = new Puzzle(puzzleOptions);
    puzzle.generate().then((_) {
      print("=================");
      print(testTitle);
      print("-----------------");
      printGrid(puzzle.solvedBoard());
      print("-----------------");
      printGrid(puzzle.board());
      print("=================");
    });
  }

  String testTitle02 = 'Test Puzzle Generation. Pattern: Spring.';
  test(testTitle02, () {
    testPatternPuzzle(testTitle02, "Spring");
  });


  String testTitle03 = 'Test Puzzle Generation. Pattern: Summer.';
  test(testTitle03, () {
    testPatternPuzzle(testTitle03, "Summer");
  });

  String testTitle04 = 'Test Puzzle Generation. Pattern: Fall.';
  test(testTitle04, () {
    testPatternPuzzle(testTitle04, "Fall");
  });

  String testTitle05 = 'Test Puzzle Generation. Pattern: Winter.';
  test(testTitle05, () {
    testPatternPuzzle(testTitle05, "Winter");
  });

  String testTitle06 = 'Test Grid-level listener for cell change';
  test(testTitle06, () {

    final PuzzleOptions puzzleOptions = new PuzzleOptions(difficulty: 3);
    final Puzzle puzzle = new Puzzle(puzzleOptions);
    Position randPos;

    puzzle.generate().then((_) {
      print("=================");
      print(testTitle01);
      print("-----------------");
      printGrid(puzzle.solvedBoard());
      print("-----------------");
      printGrid(puzzle.board());
      print("-----------------");

      while(true) {
        randPos = getRandomPosition();
        if(!puzzle.board().matrix()[randPos.grid.x][randPos.grid.y].prefill()) {
          puzzle.board().matrix()[randPos.grid.x][randPos.grid.y].setValue(1);
          break;
        }
      }
      print("=================");
    });
  });
}
