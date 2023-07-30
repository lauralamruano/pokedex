import 'package:get_it/get_it.dart';
import 'package:pokedex/ui/bloc/welcome/welcome_bloc.dart';

void registerBlocs(GetIt sl){
  sl.registerFactory(() => WelcomeBloc(sl.get()));
}