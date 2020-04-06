
///
///
class Pattern {

  String _name;
  Map<int, String> _map;
  int _difficulty;
  String _author;

  Pattern(String name, Map<int, String> map,
      {int difficulty = 0, String author}) {
    _name = name;
    _map = map;
    _difficulty = difficulty;
    _author = (author == null || author.isEmpty) ? "Anonymous" : author;
  }

  String getName() => _name;
  Map<int, String> getMap() => _map;


}
