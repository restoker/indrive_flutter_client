import 'package:formz/formz.dart';

enum PasswordRegisterError { empty, length, match }

class PasswordRegister extends FormzInput<String, PasswordRegisterError> {
  final String confirmPassword;
  const PasswordRegister.pure({required this.confirmPassword}) : super.pure('');
  const PasswordRegister.dirty({
    required String value,
    required this.confirmPassword,
  }) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == PasswordRegisterError.empty) {
      return 'El campo es requerido';
    }
    if (displayError == PasswordRegisterError.length) {
      return 'El campo debe tener al menos 5 caracteres';
    }
    if (displayError == PasswordRegisterError.match) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  @override
  PasswordRegisterError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return PasswordRegisterError.empty;
    }
    if (value.length < 5) return PasswordRegisterError.length;
    if (value != confirmPassword) return PasswordRegisterError.match;
    return null;
  }
}
