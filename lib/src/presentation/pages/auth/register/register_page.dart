import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/register/bloc/register_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/register/register_content.dart';
import 'package:rive/rive.dart' as rive;

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  bottom: 200,
                  left: 100,
                  width: MediaQuery.of(context).size.width * 1.7,
                  child: Image.asset(
                    "assets/img/Spline.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
                    child: Container(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                rive.RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                SingleChildScrollView(
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
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 29,
                            ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      BlocListener<RegisterBloc, RegisterState>(
                        listener: (context, state) {
                          if (state.formStatus == FormStatus.validating) {
                            // add loader
                            SimpleDialog(
                              backgroundColor: Colors
                                  .transparent, //here set the color to transparent
                              elevation: 0,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Cargando...',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }

                          if (state.formStatus == FormStatus.posting) {
                            // show loading
                            SimpleDialog(
                              backgroundColor: Colors
                                  .transparent, //here set the color to transparent
                              elevation: 0,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Cargando...',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                        child: BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            return RegisterContent(state: state);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
