
import 'package:tuple/tuple.dart';
import 'Pattern.dart' as MY;
import 'package:collection/collection.dart';

import '../logic/SudokuException.dart';

/// Character code for '1' digit, which is clue placeholder in patterns
final int HOLDER_CODE = 49;

/// PatternSet collection
///
class PatternSet<Pattern> extends DelegatingList<MY.Pattern> {

  final List<MY.Pattern> _l;

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


  PatternSet() : this._(<Pattern>[]);


  PatternSet._(l) :
      _l = l,
      super(l);


  void loadDefaults() {
    _l.add(new MY.Pattern("Random", null));

    _l.add(new MY.Pattern("Spring", _spring, difficulty: 29));
    _l.add(new MY.Pattern("Summer", _summer, difficulty: 27));
    _l.add(new MY.Pattern("Fall", _fall, difficulty: 24));
    _l.add(new MY.Pattern("Winter", _winter, difficulty: 31));
  }


  @override
  void add(MY.Pattern element) {
    if(element.getName() == null || element.getName().isEmpty) {
      throw InvalidPatternException("Pattern is missing name");
    } else if (!checkValidPatternMap(element.getMap()).item1) {
      throw InvalidPatternException("Pattern format for ${element.getName()} "
          "is broken");
    } else {
      _l.add(element);
    }
  }


  Tuple2<bool, List<String>> checkValidPatternMap(Map<int, String> map) {
    String _patrow = "";
    String _bigrow = "";
    List<String> _reasons = new List<String>();

    for (int row = 0; row < 9; row++) {
      _patrow = map[row].replaceAll(' ', '');

      if (_patrow.length != 9) {
        _reasons.add("Pattern Map row #${row} does not "
            + "have 9 characters (expected: 9, actual: ${_patrow.length})");
      }
      _bigrow += _patrow;
    }

    if (!_bigrow.contains(String.fromCharCode(HOLDER_CODE))) {
      _reasons.add("Pattern does not contain any "
          "placeholders. Represent which cell to keep as '1'");
    }

    return new Tuple2<bool, List<String>>(_reasons.isEmpty, _reasons);
  }

  @override
  void set length(int newLength) { _l.length = newLength; }

  @override
  int get length => _l.length;

  @override
  MY.Pattern operator [](int index) => _l[index];

  @override
  void operator []=(int index, MY.Pattern value) { _l[index] = value; }

}
