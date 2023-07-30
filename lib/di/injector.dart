
import 'package:get_it/get_it.dart';

import 'package:pokedex/di/di.dart';

enum FlavorEnum { production, staging, development }

class Injector {
  Injector._init() {
    registerCommonImpl(sl);
    registerApiLayer(sl);
    registerBlocs(sl);
    registerUseCaseLayer(sl);
    registerRepositoryLayer(sl);
  }

  static Injector? instance;

  final sl = GetIt.instance;

  ///Environment
  static late FlavorEnum environment;

  ///Init the injector with Prod configurations
  static void initProd() {
    environment = FlavorEnum.production;

    instance ??= Injector._init();
  }

  static void initStaging() {
    environment = FlavorEnum.staging;

    instance ??= Injector._init();
  }

  static void initDev() {
    environment = FlavorEnum.development;

    instance ??= Injector._init();
  }

  T getDependency<T extends Object>() => sl.get();
}