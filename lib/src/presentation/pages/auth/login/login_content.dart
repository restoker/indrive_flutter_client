import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrive_flutter_client/src/infra/inputs/email.dart';
import 'package:indrive_flutter_client/src/infra/inputs/password.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/login/bloc/login_bloc.dart';
import 'package:flutter/services.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.watch<LoginBloc>();

    // final twoFactor = loginBloc.state.twoFactor;
    final twoFactor = true;

    return twoFactor
        ? LoginFormWithTwoFactor(context: context)
        : LoginFormWithoutTwoFactor(context: context);
  }
}

class LoginFormWithoutTwoFactor extends StatelessWidget {
  const LoginFormWithoutTwoFactor({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.watch<LoginBloc>();
    final email = loginBloc.state.email;
    final password = loginBloc.state.password;
    final passwordReveal = loginBloc.state.passwordReveal;
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
            obscureText: !passwordReveal,
            decoration: InputDecoration(
              errorText: password.errorMessage,
              label: Text('Contraseña', style: TextStyle(fontSize: 18)),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  passwordReveal ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => loginBloc.add(TogglePasswordEvent()),
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
          onPressed: () =>
              Navigator.of(context, rootNavigator: true).pushNamed('register'),
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

class LoginFormWithTwoFactor extends StatelessWidget {
  const LoginFormWithTwoFactor({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    // final loginBloc = context.watch<LoginBloc>();
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text(
          "OTP Verification",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Se envio un codigo a tu correo electronico \nEste codigo expira en 2 horas",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 17, 15, 15)),
        ),
        // const SizedBox(height: 16),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        OtpForm(context: context),
      ],
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

class OtpForm extends StatelessWidget {
  const OtpForm({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.watch<LoginBloc>();
    final pin1 = loginBloc.state.pin1;
    final pin2 = loginBloc.state.pin2;
    final pin3 = loginBloc.state.pin3;
    final pin4 = loginBloc.state.pin4;
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 64,
                width: 64,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    loginBloc.add(Ping1Changed(pin1: int.parse(pin)));
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "0",
                    hintStyle: const TextStyle(color: Color(0xFF757575)),
                    border: authOutlineInputBorder,
                    enabledBorder: authOutlineInputBorder,
                    focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: Color(0xFF00BF6D)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 64,
                width: 64,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    loginBloc.add(Ping2Changed(pin2: int.parse(pin)));
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "0",
                    hintStyle: const TextStyle(color: Color(0xFF757575)),
                    border: authOutlineInputBorder,
                    enabledBorder: authOutlineInputBorder,
                    focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: Color(0xFF00BF6D)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 64,
                width: 64,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    loginBloc.add(Ping3Changed(pin3: int.parse(pin)));
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "0",
                    hintStyle: const TextStyle(color: Color(0xFF757575)),
                    border: authOutlineInputBorder,
                    enabledBorder: authOutlineInputBorder,
                    focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: Color(0xFF00BF6D)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 64,
                width: 64,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    loginBloc.add(Ping4Changed(pin4: int.parse(pin)));
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "0",
                    hintStyle: const TextStyle(color: Color(0xFF757575)),
                    border: authOutlineInputBorder,
                    enabledBorder: authOutlineInputBorder,
                    focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: Color(0xFF00BF6D)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // inspect(loginBloc.state);
              loginBloc.add(LoginSubmitTwoFactorEvent());
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFF00BF6D),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            child: const Text("Ingresar", style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
