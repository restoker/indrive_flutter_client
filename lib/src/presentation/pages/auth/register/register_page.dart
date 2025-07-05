import 'package:flutter/material.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/register/register_content.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.08),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset("assets/img/logo.jpg", height: 100),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.08),
                  Text(
                    "Registro",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 29,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  RegisterContent(formKey: _formKey),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
