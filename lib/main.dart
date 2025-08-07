import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indrive_flutter_client/injection.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/auth_use_cases.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/login/bloc/login_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/register/bloc/register_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/router.dart';
import 'package:indrive_flutter_client/src/presentation/pages/client/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LoginBloc(locator<AuthUseCases>())..add(LoginInitEvent()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc()..add(RegisterInitEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Recicle App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        theme: ThemeData(useMaterial3: true),
        builder: FToastBuilder(),
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'register': (BuildContext context) => RegisterPage(),
          'client/home': (BuildContext context) => ClientHomePage(),
        },
      ),
    );
  }
}
