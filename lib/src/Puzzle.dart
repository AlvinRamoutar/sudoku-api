import 'dart:async';

import 'Patterner.dart';
import 'Solver.dart';

import 'logic/PuzzleUtils.dart';

import 'models/Cell.dart';
import 'models/Grid.dart';
import 'models/Position.dart';
import 'models/PuzzleOptions.dart';

/// Sudoku Puzzle Class
/// Handles:
/// - Puzzle options
/// - Generation
/// - Observable grid change
/// - Stopwatch
class Puzzle {
  Solver _solver;
  Grid _board;
  Patterner _patterner;
  PuzzleOptions _options;
  Stopwatch _stopwatch;

  StreamSubscription _boardChangeStreamSub;
  Function(Cell) _onChangeHandler;

  /// Constructs a new Sudoku puzzle - don't forget to run [generate]
  Puzzle(PuzzleOptions options) {
    _options = options;
    _stopwatch = new Stopwatch();
    _solver = new Solver();
    _patterner = new Patterner();
  }

  /// Generates a new puzzle using parameters set in [_options]
  Future<bool> generate() async {
    await _solver.solve();
    _board = deepClone(_solver.solvedBoard());

    if (_options.patternName == "Random") {
      _patterner.buildGridFromRandom(
          _board, difficultyMap[_options.difficulty]);
    } else {
      _patterner.buildGridFromPattern(_board, _options.patternName);
    }

    _board.startListening();
    _boardChangeStreamSub =
        _board.change.listen((cell) => _onBoardChange(cell));

    return true;
  }

  /// Calls supplied [_onChangeHandler], if you have any assigned through
  /// [onBoardChange]
  void _onBoardChange(Cell cell) {
    if (_onChangeHandler != null) {
      _onChangeHandler(cell);
    }
  }

  /// Set a [handler] function, which will be called whenever the grid changes.
  /// A change is whenever a cell experiences a change in value.
  void onBoardChange(Function(Cell) handler) {
    _onChangeHandler = handler;
  }

  /// Fill a particular [Cell] at [position] with [value], and returns a list of
  /// [CellViolation]
  /// For what violations are, please refer to [CellViolation] enum
  List<CellViolation> fillCell(Position position, int value) {
    Cell _target = _board.cellAt(position);
    _target.setValue(value);

    List<CellViolation> _violations = new List<CellViolation>();

    if (board().isRowViolated(position)) {
      _violations.add(CellViolation.Row);
    }
    if (board().isColumnViolated(position)) {
      _violations.add(CellViolation.Column);
    }
    if (board().isSegmentViolated(position)) {
      _violations.add(CellViolation.Segment);
    }
    if (_target.getValue() !=
        _solver.solvedBoard().cellAt(position).getValue()) {
      _violations.add(CellViolation.Solution);
    }

    return _violations;
  }

  /// Terminate listeners, and prepare [Puzzle] for closure
  void dispose() {
    _boardChangeStreamSub.cancel();
    _board.stopListening();
  }

  /// Getters and setters
  /// I can only make these comments so interesting and no more :l
  void startStopwatch() => _stopwatch.start();
  void stopStopwatch() => _stopwatch.stop();
  Duration getTimeElapsed() => _stopwatch.elapsed;

  Grid board() => this._board;
  Grid solvedBoard() => this._solver.solvedBoard();
}
