import 'package:formz/formz.dart';
import 'package:pokedex/core/error/validations.dart';

class WelcomeFieldName extends FormzInput<String, String> {
  const WelcomeFieldName.pure() : super.pure('');

  const WelcomeFieldName.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    if (value.trim().isEmpty) {
      return ValidationErrors.empty;
    } else {
      return null;
    }
  }
}
