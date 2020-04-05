
import 'Position.dart';

///
///
abstract class ICell {

  final Position position;
  bool isPristine;

  ICell(this.position);

  Position getPosition();

  bool pristine() => this.isPristine;
  void setPristine(bool pristine) => this.isPristine = pristine;

}