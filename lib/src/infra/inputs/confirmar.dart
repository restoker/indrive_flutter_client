import 'package:formz/formz.dart';

enum ConfirmarPasswordError { empty, length, match }

class ConfirmarPassword extends FormzInput<String, ConfirmarPasswordError> {
  final String password;
  const ConfirmarPassword.pure({required this.password}) : super.pure('');
  const ConfirmarPassword.dirty({required this.password, required String value})
    : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == ConfirmarPasswordError.empty) {
      return 'El campo es requerido';
    }
    if (displayError == ConfirmarPasswordError.length) {
      return 'El campo debe tener al menos 5 caracteres';
    }
    if (displayError == ConfirmarPasswordError.match) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  @override
  ConfirmarPasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return ConfirmarPasswordError.empty;
    }
    if (value != password) {
      return ConfirmarPasswordError.match;
    }
    if (value.length < 5) {
      return ConfirmarPasswordError.length;
    }
    return null;
  }
}
