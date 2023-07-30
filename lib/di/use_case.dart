import 'package:get_it/get_it.dart';
import 'package:pokedex/domain/use_cases/sign_in_use_case.dart';

void registerUseCaseLayer(GetIt sl) {
  sl.registerFactory(() => SignInUseCase(sl.get()));
}