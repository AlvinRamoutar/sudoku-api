
import 'Position.dart';

abstract class ICell {

  final Position position;
  bool isPristine;

  ICell(this.position);

  Position getPosition();

  bool pristine() {
    return this.isPristine;
  }

}