import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/login/bloc/login_bloc.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.watch<LoginBloc>();
    final email = loginBloc.state.email;
    final password = loginBloc.state.password;

    return Column(
      children: [
        TextFormField(
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            errorText: email.errorMessage,
            label: Text('Email', style: TextStyle(fontSize: 18)),
            prefixIcon: Icon(Icons.email),
            hintText: 'Email',
            hintStyle: TextStyle(fontSize: 18),
            filled: true,
            fillColor: Color(0xFFF5FCF9),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.0 * 1.5,
              vertical: 16.0,
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
            loginBloc.add(EmailChanged(email: email));
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            style: TextStyle(fontSize: 18),
            obscureText: true,
            decoration: InputDecoration(
              errorText: password.errorMessage,
              label: Text('Contraseña', style: TextStyle(fontSize: 18)),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(Icons.visibility),
                onPressed: () {},
              ),
              hintText: 'Contraseña',
              hintStyle: TextStyle(fontSize: 18),
              filled: true,
              fillColor: Color(0xFFF5FCF9),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0 * 1.5,
                vertical: 16.0,
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
            onChanged: (password) {
              loginBloc.add(PasswordChanged(password: password));
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            loginBloc.add(LoginSubmitEvent());
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xFF00BF6D),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 48),
            shape: const StadiumBorder(),
          ),
          child: const Text("Ingresar", style: TextStyle(fontSize: 20)),
        ),
        const SizedBox(height: 16.0),
        TextButton(
          onPressed: () {
            loginBloc.add(LoginSubmitEvent());
          },
          child: Text(
            '¿Olvidaste tu contraseña?',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(
                context,
              ).textTheme.bodyLarge!.color!.withValues(alpha: 0.94),
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: Text.rich(
            const TextSpan(
              style: TextStyle(fontSize: 16, color: Colors.black),
              text: "¿No tienes una cuenta? ",
              children: [
                TextSpan(
                  text: "Registrarse",
                  style: TextStyle(color: Color(0xFF00BF6D)),
                ),
              ],
            ),
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(215, 0, 0, 0).withAlpha(128),
            ),
          ),
        ),
      ],
    );
  }
}
