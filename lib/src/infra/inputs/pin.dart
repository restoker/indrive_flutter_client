import 'package:formz/formz.dart';

enum PinError { integer, length, empty }

class Pin extends FormzInput<int, PinError> {
  const Pin.pure() : super.pure(0);
  const Pin.dirty(int value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == PinError.integer) {
      return 'El campo debe ser un número entero';
    }
    if (displayError == PinError.length) {
      return 'El campo debe tener un solo dígito';
    }
    if (displayError == PinError.empty) return 'El campo es requerido';
    return null;
  }

  @override
  PinError? validator(int value) {
    bool isInteger(num value) => value is int || value == value.roundToDouble();
    if (value.toString().isEmpty || value.toString().trim().isEmpty) {
      return PinError.empty;
    }
    if (!isInteger(value)) {
      return PinError.integer;
    }
    if (value.toString().length != 1) return PinError.length;
    return null;
  }
}
