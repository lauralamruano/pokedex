// import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:pokedex/core/platform/shared_prefs.dart';

// import 'package:ulula/core/network/network.dart';
// import 'package:ulula/core/platform/platform.dart';
// import 'package:ulula/core/utils/utils.dart';

void registerCommonImpl(GetIt sl) {
  sl.registerSingleton<SharedPreferencesManager>(
    SharedPreferencesManagerImpl(),
  );
}
