import 'package:test/test.dart';
import 'package:sudoku_api/sudoku_api.dart';

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

  test("Prefill validity in active board", () {
    final PuzzleOptions puzzleOptions = new PuzzleOptions(difficulty: 3);
    final Puzzle puzzle = new Puzzle(puzzleOptions);
    puzzle.generate().then((_) {

      bool isCellFilled;
      bool isPrefillValue;
      for(int r = 0; r < 9; r++) {
        for(Cell c in puzzle.board().getRow(r)) {
          isCellFilled = c.getValue() != 0;
          isPrefillValue = puzzle.board().cellAt(c.getPosition()).prefill();

          // If the value of the cell is 0, then we are expecting prefill to be
          // false. Likewise, if value of cell is NOT 0, then prefill should be
          // true.
          expect(isCellFilled, isPrefillValue);
        }
      }
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
    testPatternPuzzle(testTitle02, "spring");
  });


  String testTitle03 = 'Test Puzzle Generation. Pattern: Summer.';
  test(testTitle03, () {
    testPatternPuzzle(testTitle03, "summer");
  });

  String testTitle04 = 'Test Puzzle Generation. Pattern: Fall.';
  test(testTitle04, () {
    testPatternPuzzle(testTitle04, "fall");
  });

  String testTitle05 = 'Test Puzzle Generation. Pattern: Winter.';
  test(testTitle05, () {
    testPatternPuzzle(testTitle05, "winter");
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
