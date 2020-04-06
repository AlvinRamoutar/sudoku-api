
import 'package:sudokuapi/src/logic/GridUtils.dart';
import 'package:sudokuapi/src/logic/PuzzleUtils.dart';

import 'Patterner.dart';
import 'Solver.dart';
import 'models/Grid.dart';
import 'models/PuzzleOptions.dart';

///
///
class Puzzle {

  Solver _solver;
  Grid _board;
  Patterner _patterner;
  PuzzleOptions _options;
  Stopwatch _stopwatch;

  ///
  ///
  Puzzle(PuzzleOptions options) {
    _options = options;
    _stopwatch = new Stopwatch();
    _solver = new Solver();
    _patterner = new Patterner();
  }

  ///
  ///
  Future<void> generateRandom() async {
    await _solver.solve();
    _board = deepClone(_solver.solvedBoard());
    _patterner.buildGridFromRandom(_board,
      difficultyMap[_options.difficulty]);
  }

  ///
  ///
  Future<void> generatefromPattern() async {
    await _solver.solve();
    _board = deepClone(_solver.solvedBoard());

    _patterner.buildGridFromPattern(_board, _options.patternName);
  }

  ///
  ///
  void startStopwatch() => _stopwatch.start();
  void stopStopwatch() => _stopwatch.stop();
  Duration getTimeElapsed() => _stopwatch.elapsed;

  Grid board() => this._board;
  Grid solvedBoard() => this._solver.solvedBoard();

}