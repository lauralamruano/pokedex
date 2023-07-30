import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/core/error/failures.dart';



// ignore: one_member_abstracts
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class Params<T> extends Equatable {
  const Params(this.request);

  final T request;

  @override
  List<Object> get props => [
    request as Object,
  ];
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}