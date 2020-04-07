
/// Map representing level <=> difficulty linguistic term
Map<int, String> difficultyLinguisticMap = {
  0: "custom",
  1: "easy",
  2: "normal",
  3: "hard"
};

/// Map representing level <=> cells given
Map<int, int> difficultyMap = {
  0: 0,
  1: 32,
  2: 26,
  3: 20,
};

enum CellViolation {
  Row,
  Column,
  Segment,
  Solution
}