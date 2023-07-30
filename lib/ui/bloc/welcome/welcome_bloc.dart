import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:pokedex/core/utils/app_alerts.dart';
import 'package:pokedex/domain/model/form/welcome_field_name.dart';
import 'package:pokedex/domain/model/request/sign_in.dart';
import 'package:pokedex/domain/use_cases/use_case.dart';

import '../../../domain/use_cases/sign_in_use_case.dart';

part 'welcome_event.dart';

part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc(
    this._signInUseCase,
  ) : super(const WelcomeState()) {
    on<WelcomeNameChanged>(_onNameChanged);
    on<WelcomeNameUnfocused>(_onUnfocused);
    on<WelcomeFormSubmitted>(_onFormSubmitted);
  }

  final SignInUseCase _signInUseCase;


  void _onNameChanged(WelcomeNameChanged event, Emitter<WelcomeState> emit) {
    final name = WelcomeFieldName.dirty(event.name);
    emit(
      state.copyWith(
        name: name.isValid ? name : const WelcomeFieldName.pure(),
        formStatus: Formz.validate([name])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.failure,
      ),
    );
  }

  void _onUnfocused(
    WelcomeNameUnfocused event,
    Emitter<WelcomeState> emit,
  ) {
    final name = WelcomeFieldName.dirty(state.name.value);
    emit(state.copyWith(
      name: name,
      formStatus: Formz.validate([name])
          ? FormzSubmissionStatus.initial
          : FormzSubmissionStatus.failure,
    ));
  }

  Future<void> _onFormSubmitted(
    WelcomeFormSubmitted event,
    Emitter<WelcomeState> emit,
  ) async {
    final name = WelcomeFieldName.dirty(state.name.value);
    emit(
      state.copyWith(
        name: name,
        formStatus: Formz.validate([name])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.failure,
      ),
    );
    if (state.formStatus != FormzSubmissionStatus.failure) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      final resp = await _signInUseCase(
        Params(
          SignInRequestModel(
            name: name.value,
          ),
        ),
      );
      emit(
        resp.fold((l) {
          AppAlerts.showErrorMessage(l.message?? '');
          return state.copyWith(formStatus: FormzSubmissionStatus.failure);
        }, (r) {
          return state.copyWith(formStatus: FormzSubmissionStatus.success);
        }),
      );
    }
  }
}
