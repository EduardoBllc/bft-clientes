import 'loggable.dart';
import 'mappable.dart';

mixin Registerable implements Loggable, Mappable {
  int get id;
}
