import 'package:formz/formz.dart';

enum TelefonoError { empty, length, format }

class Telefono extends FormzInput<String, TelefonoError> {
  static final RegExp telefonoRegExp = RegExp(r'^(9|7)\d{8}$');
  const Telefono.pure() : super.pure('');
  const Telefono.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == TelefonoError.empty) return 'El campo es requerido';
    if (displayError == TelefonoError.length) {
      return 'El campo debe tener 9 caracteres';
    }
    if (displayError == TelefonoError.format) {
      return 'Número de teléfono inválido en Perú';
    }
    return null;
  }

  @override
  TelefonoError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TelefonoError.empty;
    if (value.length != 9) return TelefonoError.length;
    if (!telefonoRegExp.hasMatch(value)) return TelefonoError.format;
    return null;
  }
}
