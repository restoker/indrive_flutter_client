import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/login/bloc/login_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/login/login_content.dart';
import 'package:rive/rive.dart' as rive;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                rive.RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.1),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset("assets/img/logo.jpg", height: 100),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.1),
                      Text(
                        "Ingresar",
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state.formStatus == FormStatus.error) {
                            Fluttertoast.showToast(
                              msg: "Ingrese el código",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                          if (state.formStatus == FormStatus.session) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              'client/home',
                              (route) => false,
                            );
                          }

                          if (state.formStatus == FormStatus.valid) {
                            Fluttertoast.showToast(
                              msg: "Bienvenido nuevamente",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              'client/home',
                              (route) => false,
                            );
                          }
                        },
                        child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return Form(
                              key: state.formKey,
                              child: LoginContent(),
                            );
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
