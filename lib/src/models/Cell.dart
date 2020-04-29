import 'dart:async';

import '../logic/PuzzleUtils.dart';
import 'ICell.dart';
import 'Position.dart';

/// Represents a single cell in a 9x9 grid
class Cell extends ICell {
  /// Value of the cell in range [1-9]
  int _value;

  /// Does this cell have a value, initially?
  bool _isPrefill;

  /// Does this cell match its solution counterpart?
  /// Meaning, it must possess NO [CellViolation]
  bool _isValid;

  /// Is this cell in markup mode?
  bool _isMarkup = false;

  StreamController _onChange;

  /// Constructs new Cell at [position] with optional [_value]
  /// If value is provided, then cell is flagged as prefilled
  Cell(position, [this._value = 0]) : super(position, true) {
    _isPrefill = (_value != 0);
    _isValid = _isPrefill;

    _onChange = new StreamController.broadcast();
  }

  Cell._(
      {int value,
      bool isPrefill,
      bool isValid,
      bool isMarkup,
      bool isPristine,
      Position position})
      : this._isPrefill = isPrefill,
        this._value = value,
        this._isValid = isValid,
        this._isMarkup = isMarkup,
        super(position, isPristine) {
    _onChange = new StreamController.broadcast();
  }

  /// Serialization
  ///
  factory Cell.fromMap(Map<String, dynamic> json) => Cell._(
        value: json["value"] == null ? null : json["value"],
        isPrefill: json["is_prefill"] == null ? null : json["is_prefill"],
        isValid: json["is_valid"] == null ? null : json["is_valid"],
        isMarkup: json["is_markup"] == null ? null : json["is_markup"],
        isPristine: json["is_pristine"] == null ? null : json["is_pristine"],
        position: json["position"] == null
            ? null
            : Position.fromMap(json["position"]),
      );

  Map<String, dynamic> toMap() => {
        "value": _value == null ? null : _value,
        "is_prefill": _isPrefill == null ? null : _isPrefill,
        "is_valid": _isValid == null ? null : _isValid,
        "is_markup": _isMarkup == null ? null : _isMarkup,
        "is_pristine": isPristine == null ? null : isPristine,
        "position": position == null ? null : position.toMap(),
      };

  /// Sets [value] of cell while poking [_onChange]
  void setValue(int value) {
    this._value = value;
    this.isPristine = false;

    _onChange.add(this);
  }

  /// Clears a cell as if it was never prefilled
  /// Used in grid generation to clear clues in forming patterns
  void clear() {
    this.isPristine = true;
    this._value = 0;
    this._isPrefill = false;
    this._isValid = false;
    this._isValid = false;
  }

  /// Getters and setters
  /// I can only make these comments so interesting and no more :l
  bool pristine() => this.isPristine;

  void setPristine(bool pristine) => this.isPristine = pristine;

  Stream get change => _onChange.stream.asBroadcastStream();

  int getValue() => this._value;

  void setPrefill(bool isPrefilled) => this._isPrefill = isPrefilled;

  bool prefill() => this._isPrefill;

  void setValidity(bool isValid) => this._isValid = isValid;

  bool valid() => this._isValid;

  void setMarkup(bool markup) => this._isMarkup = markup;

  bool markup() => this._isMarkup;

  Position getPosition() => position;

  /// Equitable cells, determined by position
  @override
  bool operator ==(dynamic obj) {
    if (obj is Cell && obj.getPosition() == getPosition()) {
      return true;
    }
    return false;
  }

  @override
  int get hashCode => position.hashCode;
}
