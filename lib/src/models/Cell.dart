
import 'dart:async';

import 'ICell.dart';
import 'Position.dart';

class Cell extends ICell {

  int _value;

  bool _isPrefill;
  bool _isValid;
  bool _isMarkup = false;

  StreamController onChange;

  Cell(position, [this._value = 0]) : super(position) {
    _isPrefill = (_value != 0);
    _isValid = _isPrefill;

    onChange = new StreamController.broadcast();
  }

  Stream get change => onChange.stream;


  void setValue(int value) {
    this._value = value;
    this.isPristine = false;

    onChange.add(value);
  }

  int getValue() {
    return this._value;
  }

  bool prefill() {
    return this._isPrefill;
  }

  void setValidity(bool isValid) {
    this._isValid = isValid;
  }

  bool valid() {
    return this._isValid;
  }

  void setMarkup(bool markup) {
    this._isMarkup = markup;
  }

  bool markup() {
    return this._isMarkup;
  }

  @override
  Position getPosition() {
    return position;
  }

}