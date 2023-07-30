import 'package:get_it/get_it.dart';
import 'package:pokedex/domain/repositories/pokedex_repositories.dart';

void registerRepositoryLayer(GetIt sl) {
  sl.registerLazySingleton<PokeDexRepository>(
        () => PokeDexRepositoryImpl(
      sl(),
    ),
  );
}