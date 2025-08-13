import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indrive_flutter_client/injection.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/auth_use_cases.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/user/user_use_cases.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/login/bloc/login_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/register/bloc/register_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/router.dart';
import 'package:indrive_flutter_client/src/presentation/pages/client/home/bloc/home_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/client/route.dart';
import 'package:indrive_flutter_client/src/presentation/pages/profile/info/bloc/profile_info_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/profile/update/bloc/profile_update_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/profile/update/profile_update_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

// dart run build_runner build
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) =>
              LoginBloc(locator<AuthUseCases>())..add(LoginInitEvent()),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) =>
              RegisterBloc(locator<AuthUseCases>())..add(RegisterInitEvent()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(locator<AuthUseCases>()),
        ),
        BlocProvider<ProfileInfoBloc>(
          create: (context) =>
              ProfileInfoBloc(locator<AuthUseCases>())..add(GetUserEvent()),
        ),
        BlocProvider<ProfileUpdateBloc>(
          create: (context) => ProfileUpdateBloc(
            userUseCases: locator<UserUseCases>(),
            authUseCases: locator<AuthUseCases>(),
          ),
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
          'profile/update': (BuildContext context) => ProfileUpdatePage(),
        },
      ),
    );
  }
}
