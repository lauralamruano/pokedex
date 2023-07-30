import 'package:dartz/dartz.dart';

import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/core/platform/shared_prefs.dart';
import 'package:pokedex/domain/model/request/sign_in.dart';
import 'package:pokedex/domain/model/response/sing_in.dart';

abstract class PokeDexRepository {
  Future<Either<Failure, SignInResponseModel>> signIn(
    SignInRequestModel request,
  );
}

class PokeDexRepositoryImpl implements PokeDexRepository {
  PokeDexRepositoryImpl(
      this.sharedPreferencesManager,
      );

  final SharedPreferencesManager sharedPreferencesManager;

  @override
  Future<Either<Failure, SignInResponseModel>> signIn(
      SignInRequestModel request,
      ) async {
    try {
      final res = await sharedPreferencesManager.setUserName(request.name);

      if (!res) {
        return const Left(Failure(message: 'Failed to save user name'));
      }

      return Right(SignInResponseModel(success: res));
    } catch (ex) {
      return const Left(Failure(message: 'Failed to save user name'));
    }
  }
}