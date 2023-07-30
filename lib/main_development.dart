import 'package:pokedex/app.dart';
import 'package:pokedex/bootstrap.dart';
import 'package:pokedex/di/di.dart';

void main() {
  Injector.initDev();
  bootstrap(() => const App());
}
