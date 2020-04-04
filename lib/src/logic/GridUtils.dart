
import 'dart:math';

Point segmentFromGridPos(int row, int col) {

  int _x = (row / 3).floor();
  int _y = (col / 3).floor();

  return new Point(_x,  _y);
}