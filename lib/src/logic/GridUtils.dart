
import 'dart:math';
import '../models/Cell.dart';
import '../models/Grid.dart';
import '../models/Position.dart';
import 'SudokuException.dart';

///
///
Point segmentFromGridPos(int row, int col) {
  int _x = (row / 3).floor();
  int _y = (col / 3).floor();
  return new Point(_x,  _y);
}

///
///
void throwIfInvalidRowColQueried(int rowOrCol) {
  if(rowOrCol > 8 || rowOrCol < 0) {
    throw new InvalidSegmentException("Invalid row or column requested");
  }
}

///
///
void throwIfInvalidSegmentQueried(Position position) {
  if(position.segment.x > 2 || position.segment.x < 0 ||
     position.segment.y > 2 || position.segment.y < 0) {
    throw new InvalidSegmentException("Invalid grid segment queried");
  }
}

/// Used for debugging [grid], prints to console a somewhat-grid-shaped
/// matrix of cell value
void printGrid(Grid grid) {
  for (int r = 0; r < 9; r++) {
    String row = "";
    for (Cell c in grid.getRow(r)) {
      row += c.getValue().toString() + " ";
    }
    print(row);
  }
}