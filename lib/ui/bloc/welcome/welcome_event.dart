part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class WelcomeNameChanged extends WelcomeEvent {
  const WelcomeNameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class WelcomeNameUnfocused extends WelcomeEvent {}

class WelcomeFormSubmitted extends WelcomeEvent {}
