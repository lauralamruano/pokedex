import 'package:equatable/equatable.dart';

class SignInRequestModel extends Equatable {
  const SignInRequestModel({
    required this.name,
  });

  final String name;

  Map<String, dynamic> toJson() => {
    'name': name,
  };

  @override
  List<Object?> get props => [
    name,
  ];
}