
import 'dart:math';

import '../logic/GridUtils.dart';

///
///
class Position {

  Point grid;
  Point segment;

  Position(this.grid, this.segment);

  ///
  ///
  Position.fromRaw(int gridX, int gridY) {
    grid = new Point(gridX, gridY);
    segment = segmentFromGridPos(gridX, gridY);
  }
  
}