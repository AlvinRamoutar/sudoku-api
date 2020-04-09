/*
   Collection of Utility functions used for stuff puzzle-related
 */

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

/// Possible types of cell violations that can be committed
/// Violations:
/// - Row: Cell value already exists in that row
/// - Column: Cell value already exists in that column
/// - Segment: Cell value already exists in that segment
/// - Solution: Cell value does not match its solution board counterpart
enum CellViolation { Row, Column, Segment, Solution }
