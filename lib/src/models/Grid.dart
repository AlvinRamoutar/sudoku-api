
import 'dart:math';
import '../logic/GridUtils.dart';
import 'Position.dart';
import 'Cell.dart';

///
///
class Grid {

  List<List<Cell>> _matrix;

  ///
  ///
  Grid() {
    _matrix = List.generate(9, (_) => new List(9), growable: false);
    _buildEmpty();
  }

  ///
  ///
  void _buildEmpty() {

    for(int r = 0; r < 9; r++) {
      for(int c = 0; c < 9; c++) {

        _matrix[r][c] = new Cell(
          new Position(new Point(r, c), segmentFromGridPos(r, c))
        );

      }
    }
  }

  /// Pre-generates the first row of grid with randomized values
  void pregenFirstRow() {
    List<int> vals = new List<int>();
    for(int i = 1; i < 10; vals.add(i), i++);
    vals.shuffle();
    for(int c = 0; c < 9; c++) {
      _matrix[0][c].setValue(vals[c]);
      _matrix[0][c].setPrefill(true);
      _matrix[0][c].setValidity(true);
    }
  }


  ///
  ///
  List<Cell> getRow(int rowNum) {
    throwIfInvalidRowColQueried(rowNum);
    return _matrix[rowNum];
  }

  ///
  ///
  List<Cell> getColumn(int colNum) {
    throwIfInvalidRowColQueried(colNum);
    List<Cell> _tmpCol = new List<Cell>();

    for(int c = 0; c < 9; c++) {
      _tmpCol[c] = _matrix[c][colNum];
    }
    return _tmpCol;
  }

  ///
  ///
  List<Cell> getSegment(Position segPos) {
    throwIfInvalidSegmentQueried(segPos);
    List<Cell> _tmpSeg = new List<Cell>();

    for(int rInc = 0; rInc < 3; rInc++) {
      for(int cInc = 0; cInc < 3; cInc++) {
        _tmpSeg.add(_matrix[(segPos.segment.x * 3) + rInc][(segPos.segment.y * 3) + cInc]);
      }
    }
    return _tmpSeg;
  }

  ///
  ///
  Cell cellAt(Position pos) => _matrix[pos.grid.x][pos.grid.y];

  /// Getters and setters
  List<List<Cell>> matrix() => _matrix;


}

///
///
Grid deepClone(Grid source) {
  Grid _target = new Grid();

  for(int r = 0; r < 9; r++) {
    for(int c = 0; c < 9; c++) {
      _target.matrix()[r][c].setValidity(source.matrix()[r][c].valid());
      _target.matrix()[r][c].setPristine(source.matrix()[r][c].pristine());
      _target.matrix()[r][c].setMarkup(source.matrix()[r][c].markup());
      _target.matrix()[r][c].setValue(source.matrix()[r][c].getValue());
    }
  }
  return _target;
}