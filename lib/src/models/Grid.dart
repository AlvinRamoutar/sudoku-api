

import 'dart:math';

import 'package:sudokuapi/src/logic/GridUtils.dart';
import 'package:sudokuapi/src/models/Position.dart';

import 'Cell.dart';

class Grid {

  List<List<Cell>> _matrix;

  Grid() {
    _matrix = List.generate(9, (_) => new List(9), growable: false);
  }


  void buildEmpty() {

    for(int r = 0; r < 9; r++) {
      for(int c = 0; c < 9; c++) {

        _matrix[r][c] = new Cell(
          new Position(new Point(r, c), segmentFromGridPos(r, c))
        );

      }
    }
  }


}