
import 'dart:core';
import 'package:tuple/tuple.dart';
import 'Pattern.dart';

import '../logic/SudokuException.dart';

/// Character code for '1' digit
final int HOLDER_CODE = 49;

class PatternSet {

  List<Pattern> _collection;

  Map<int, String> _spring = {
    0: "0 0 0 0 1 0 0 0 0",
    1: "0 0 0 1 1 1 0 0 0",
    2: "0 0 0 1 0 1 0 0 0",
    3: "0 1 1 0 1 0 1 1 0",
    4: "1 1 0 1 1 1 0 1 1",
    5: "0 1 1 0 1 0 1 1 0",
    6: "0 0 0 1 0 1 0 0 0",
    7: "0 0 0 1 1 1 0 0 0",
    8: "0 0 0 0 1 0 0 0 0"
  };

  Map<int, String> _summer = {
    0: "0 0 0 0 0 1 1 0 0",
    1: "0 0 0 0 1 1 0 1 0",
    2: "0 0 0 1 1 1 0 1 0",
    3: "0 0 1 1 1 0 0 1 0",
    4: "0 1 1 0 0 0 1 1 0",
    5: "1 1 0 0 0 0 1 0 0",
    6: "1 0 0 0 1 1 0 0 0",
    7: "0 1 1 1 1 0 0 0 0",
    8: "0 0 0 0 0 0 0 0 0"
  };

  Map<int, String> _fall = {
    0: "0 0 0 0 0 0 0 0 0",
    1: "0 0 0 0 1 0 1 1 0",
    2: "0 0 0 1 0 1 1 1 0",
    3: "0 0 1 0 0 1 1 0 0",
    4: "0 0 1 1 1 0 0 1 0",
    5: "0 0 1 1 1 0 1 0 0",
    6: "0 0 1 1 1 1 0 0 0",
    7: "0 1 0 0 0 0 0 0 0",
    8: "1 0 0 0 0 0 0 0 0"
  };

  Map<int, String> _winter = {
    0: "0 1 0 0 0 0 0 1 0",
    1: "1 1 0 0 1 0 0 1 1",
    2: "0 0 1 0 1 0 1 0 0",
    3: "0 0 0 1 0 1 0 0 0",
    4: "1 1 1 0 1 0 1 1 1",
    5: "0 0 0 1 0 1 0 0 0",
    6: "0 0 1 0 1 0 1 0 0",
    7: "1 1 0 0 1 0 0 1 1",
    8: "0 1 0 0 0 0 0 1 0"
  };


  PatternSet() {
    _collection = new List<Pattern>();
    _collection.add(new Pattern("Random", null));

    add("Spring", _spring, difficulty: 29);
    add("Summer", _summer, difficulty: 27);
    add("Fall", _fall, difficulty: 24);
    add("Winter", _winter, difficulty: 31);
  }

  void add(String name, Map<int, String> map, {int difficulty = 0}) {
    if(name == null || name.isEmpty) {
      throw InvalidPatternException("Pattern is missing name");
    } else if (!checkValidPatternMap(map).item1) {
      throw InvalidPatternException("Pattern format for ${name} is broken");
    } else {
      _collection.add(new Pattern(name, map, difficulty: difficulty));
    }
  }

  Tuple2<bool, List<String>> checkValidPatternMap(Map<int, String> map) {

    String _patrow = "";
    String _bigrow = "";
    List<String> _reasons = new List<String>();

    for(int row = 0; row < 9; row++) {
      _patrow = map[row].replaceAll(' ', '');

      if(_patrow.length != 9) {
        _reasons.add("Pattern Map row #${row} does not "
            + "have 9 characters (expected: 9, actual: ${_patrow.length})");
      }
      _bigrow += _patrow;
    }

    if(!_bigrow.contains(String.fromCharCode(HOLDER_CODE))) {
      _reasons.add("Pattern does not contain any "
          "placeholders. Represent which cell to keep as '1'");
    }

    return new Tuple2<bool, List<String>>(_reasons.isEmpty, _reasons);
  }

  List<Pattern> collection() => _collection;

}
