import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/login/bloc/login_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/register/bloc/register_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()..add(LoginInitEvent())),
        BlocProvider(
          create: (context) => RegisterBloc()..add(RegisterInitEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Recicle App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        theme: ThemeData(useMaterial3: true),
        routes: {
          'login': (context) => LoginPage(),
          'register': (context) => RegisterPage(),
        },
      ),
    );
  }
}
