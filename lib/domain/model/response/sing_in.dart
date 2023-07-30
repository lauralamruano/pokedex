import 'package:equatable/equatable.dart';

class SignInResponseModel extends Equatable {
  const SignInResponseModel({
    required this.success,
  });

  final bool success;

  @override
  List<Object?> get props => [
    success,
  ];
}