
import 'logic/GridUtils.dart';
import 'logic/SudokuException.dart';
import 'models/PatternSet.dart';
import 'models/Pattern.dart';
import 'models/Grid.dart';
import 'models/Position.dart';

class Patterner {

  PatternSet patternSet;

  Patterner() {
    patternSet = new PatternSet();
  }

  ///
  ///
  Grid buildGridFromPattern(Grid grid, String patternName) {

    Pattern pattern = patternSet.collection().firstWhere(
      (p) => p.getName() == patternName,
      orElse: () => null);

    if(pattern == null) {
      throw new InvalidPatternException("Pattern map with name ${patternName} not found");
    }

    String _patrow = "";
    for(int row = 0; row < 9; row++) {
      _patrow = pattern.getMap()[row].replaceAll(' ', '');

      for(int col = 0; col < 9; col++) {
        if(_patrow.codeUnitAt(col) != HOLDER_CODE) {
          grid.matrix()[row][col].setValidity(false);
          grid.matrix()[row][col].setValue(0);
        }
      }
    }

    return grid;
  }

  ///
  ///
  Grid buildGridFromRandom(Grid grid, int cellsRemaining) {

    if(cellsRemaining > 80 || cellsRemaining < 1) {
      throw new InvalidPatternException("Cannot generate random grid with "
          "${cellsRemaining} cells remaining (min: 1, max: 80)");
    }

    Position pos;
    List<int> cellIndices = new List<int>();

    for(int i = 0; i < 81; cellIndices.add(i), i++);
    cellIndices.shuffle();

    while(cellIndices.length != cellsRemaining) {
      pos = positionFromIndice(cellIndices.removeLast());
      grid.matrix()[pos.grid.x][pos.grid.y].setValidity(false);
      grid.matrix()[pos.grid.x][pos.grid.y].setValue(0);
      grid.matrix()[pos.grid.x][pos.grid.y].setPrefill(false);
    }

    return grid;
  }

}