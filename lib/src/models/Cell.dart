
import 'dart:async';

import 'ICell.dart';
import 'Position.dart';

class Cell extends ICell {

  int _value;

  bool _isPrefill;
  bool _isValid;
  bool _isMarkup = false;

  StreamController _onChange;

  Cell(position, [this._value = 0]) : super(position) {
    _isPrefill = (_value != 0);
    _isValid = _isPrefill;

    _onChange = new StreamController.broadcast();
  }

  Stream get change => _onChange.stream.asBroadcastStream();


  void setValue(int value) {
    this._value = value;
    this.isPristine = false;

    _onChange.add(this);
  }

  int getValue() => this._value;

  void setPrefill(bool isPrefilled) => this._isPrefill = isPrefilled;
  bool prefill() => this._isPrefill;

  void setValidity(bool isValid) => this._isValid = isValid;
  bool valid() => this._isValid;

  void setMarkup(bool markup) => this._isMarkup = markup;
  bool markup() => this._isMarkup;

  Position getPosition() => position;

  ///
  ///
  @override
  bool operator ==(dynamic obj) {

    if(obj is Cell && obj.getPosition() == getPosition()) {
      return true;
    }
    return false;
  }

}