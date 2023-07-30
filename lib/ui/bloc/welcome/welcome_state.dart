part of 'welcome_bloc.dart';

class WelcomeState extends Equatable {
  const WelcomeState({
    this.name = const WelcomeFieldName.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
  });

  final WelcomeFieldName name;
  final FormzSubmissionStatus formStatus;

  WelcomeState copyWith({
    WelcomeFieldName? name,
    FormzSubmissionStatus? formStatus,
  }) {
    return WelcomeState(
      name: name ?? this.name,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [name, formStatus];
}
