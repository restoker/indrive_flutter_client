import 'package:flutter/material.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/login/login_page.dart';

class RegisterContent extends StatelessWidget {
  const RegisterContent({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              hintText: 'Nombre completo',
              hintStyle: TextStyle(fontSize: 18),
              filled: true,
              fillColor: Color(0xFFF5FCF9),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0 * 1.5,
                vertical: 16.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            onSaved: (name) {
              // Save it
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            style: TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              hintText: 'Teléfono',
              hintStyle: TextStyle(fontSize: 18),
              filled: true,
              fillColor: Color(0xFFF5FCF9),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0 * 1.5,
                vertical: 8.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            keyboardType: TextInputType.phone,
            onSaved: (phone) {
              // Save it
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            style: TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(fontSize: 18),
              filled: true,
              fillColor: Color(0xFFF5FCF9),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0 * 1.5,
                vertical: 8.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            onSaved: (email) {
              // Save it
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextFormField(
              style: TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                hintText: 'Contraseña',
                hintStyle: TextStyle(fontSize: 18),
                filled: true,
                fillColor: Color(0xFFF5FCF9),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5,
                  vertical: 8.0,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              obscureText: true,
              onSaved: (passaword) {
                // Save it
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextFormField(
              style: TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                hintText: 'Confirmar contraseña',
                hintStyle: TextStyle(fontSize: 18),
                filled: true,
                fillColor: Color(0xFFF5FCF9),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5,
                  vertical: 8.0,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              obscureText: true,
              onSaved: (confirmPassword) {
                // Save it
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF00BF6D),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: const StadiumBorder(),
              ),
              child: const Text("Registrarse", style: TextStyle(fontSize: 18)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            ),
            child: Text.rich(
              const TextSpan(
                style: TextStyle(fontSize: 16),
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
          ),
        ],
      ),
    );
  }
}
