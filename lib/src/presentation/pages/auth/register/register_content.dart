import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/register/bloc/register_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/utils/bloc_form_item.dart';

class RegisterContent extends StatelessWidget {
  const RegisterContent({super.key, required this.state});

  final RegisterState state;

  @override
  Widget build(BuildContext context) {
    final registerBloc = context.watch<RegisterBloc>();
    // final formKey = registerBloc.state.formKey;
    final nombre = registerBloc.state.nombre;
    final telefono = registerBloc.state.telefono;
    final email = registerBloc.state.email;
    final password = registerBloc.state.password;
    final confirmarPassword = registerBloc.state.confirmarPassword;
    final passwordReveal = registerBloc.state.passwordReveal;
    final confirmarPasswordReveal = registerBloc.state.confirmarPasswordReveal;

    return Form(
      key: state.formKey,
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              errorText: nombre.error,
              prefixIcon: Icon(Icons.person),
              label: Text('Nombre completo', style: TextStyle(fontSize: 18)),
              filled: true,
              fillColor: Color(0xFFF5FCF9),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0 * 1.5,
                vertical: 8.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 62, 227, 156),
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            onChanged: (nombre) {
              registerBloc.add(
                RegisterNombreChanged(nombre: BlocFormItem(value: nombre)),
              );
            },
            validator: (value) {
              return state.nombre.error;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              errorText: telefono.error,
              prefixIcon: Icon(Icons.phone),
              label: Text('Teléfono', style: TextStyle(fontSize: 18)),
              filled: true,
              fillColor: Color(0xFFF5FCF9),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0 * 1.5,
                vertical: 8.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 62, 227, 156),
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            keyboardType: TextInputType.phone,
            onChanged: (telefono) {
              registerBloc.add(
                RegisterTelefonoChanged(
                  telefono: BlocFormItem(value: telefono),
                ),
              );
            },
            validator: (value) {
              return state.telefono.error;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              errorText: email.error,
              prefixIcon: Icon(Icons.email),
              label: Text('Email', style: TextStyle(fontSize: 18)),
              filled: true,
              fillColor: Color(0xFFF5FCF9),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0 * 1.5,
                vertical: 8.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 62, 227, 156),
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) {
              registerBloc.add(
                RegisterEmailChanged(email: BlocFormItem(value: email)),
              );
            },
            validator: (value) {
              return state.email.error;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextFormField(
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                errorText: password.error,
                label: Text('Contraseña', style: TextStyle(fontSize: 18)),
                prefixIcon: Icon(Icons.lock_clock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordReveal ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => registerBloc.add(TogglePasswordEvent()),
                ),
                filled: true,
                fillColor: Color(0xFFF5FCF9),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5,
                  vertical: 8.0,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 62, 227, 156),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              obscureText: !passwordReveal,
              onChanged: (password) {
                registerBloc.add(
                  RegisterPasswordChanged(
                    password: BlocFormItem(value: password),
                  ),
                );
              },
              validator: (value) {
                return state.password.error;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextFormField(
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                errorText: confirmarPassword.error,
                label: Text(
                  'Confirmar contraseña',
                  style: TextStyle(fontSize: 18),
                ),
                prefixIcon: Icon(Icons.lock_clock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    confirmarPasswordReveal
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () =>
                      registerBloc.add(ToggleConfirmarPasswordEvent()),
                ),
                filled: true,
                fillColor: Color(0xFFF5FCF9),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5,
                  vertical: 8.0,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 62, 227, 156),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              obscureText: !confirmarPasswordReveal,
              onChanged: (confirmPassword) {
                registerBloc.add(
                  RegisterConfirmarPasswordChanged(
                    confirmarPassword: BlocFormItem(value: confirmPassword),
                  ),
                );
              },
              validator: (value) {
                return state.confirmarPassword.error;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validar que el formulario sea valido
                final isValid = state.formKey!.currentState!.validate();
                if (isValid) {
                  registerBloc.add(RegisterSubmit());
                  // registerBloc.add(FormReset());
                } else {
                  Fluttertoast.showToast(
                    msg: 'El formulario no es valido',
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.redAccent,
                    webShowClose: true,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF00BF6D),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: const StadiumBorder(),
              ),
              child: const Text("Registrarse", style: TextStyle(fontSize: 20)),
            ),
          ),
          TextButton(
            child: Text.rich(
              const TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                text: "Ya tienes una cuenta? ",
                children: [
                  TextSpan(
                    text: "Iniciar sesión",
                    style: TextStyle(color: Color(0xFF00BF6D)),
                  ),
                ],
              ),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge!.color!.withValues(alpha: 0.64),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(context),
          ),
        ],
      ),
    );
  }
}
