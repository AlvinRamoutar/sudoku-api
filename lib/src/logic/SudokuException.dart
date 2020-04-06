
///
///
class InvalidRowOrColumnException implements Exception {
  String cause;
  InvalidRowOrColumnException(this.cause);
}

///
///
class InvalidSegmentException implements Exception {
  String cause;
  InvalidSegmentException(this.cause);
}

///
///
class InvalidPatternException implements Exception {
  String cause;
  InvalidPatternException(this.cause);
}