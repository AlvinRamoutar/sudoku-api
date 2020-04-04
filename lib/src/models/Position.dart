
import 'dart:math';

class Position {

  Point grid;
  Point segment;

  Position(this.grid, this.segment);

  Position.fromRaw(int gridX, int gridY, int segmentX, int segmentY) {
    grid = new Point(gridX, gridY);
    segment = new Point(segmentX, segmentY);
  }
  
}