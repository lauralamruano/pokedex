import 'package:dartz/dartz.dart'
;
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/domain/model/request/sign_in.dart';
import 'package:pokedex/domain/model/response/sing_in.dart';
import 'package:pokedex/domain/repositories/pokedex_repositories.dart';
import 'package:pokedex/domain/use_cases/use_case.dart';

class SignInUseCase
    implements UseCase<SignInResponseModel, Params<SignInRequestModel>> {
  SignInUseCase(this.repository);

  final PokeDexRepository repository;

  @override
  Future<Either<Failure, SignInResponseModel>> call(
      Params<SignInRequestModel> params,
      ) async {
    return repository.signIn(params.request);
  }
}