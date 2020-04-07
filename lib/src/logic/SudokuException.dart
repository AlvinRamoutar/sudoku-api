

///
///
class InvalidPositionException implements Exception {
  String cause;

  InvalidPositionException(this.cause);
}


///
///
class InvalidPatternException implements Exception {
  String cause;
  InvalidPatternException(this.cause);
}