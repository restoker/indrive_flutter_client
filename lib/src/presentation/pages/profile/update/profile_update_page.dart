import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indrive_flutter_client/src/domain/models/index.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:indrive_flutter_client/src/presentation/pages/profile/info/bloc/profile_info_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/profile/update/bloc/profile_update_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/profile/update/profile_update_content.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  User? user;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileUpdateBloc>().add(ProfileUpdateInitEvent(user: user));
    });
  }

  @override
  Widget build(BuildContext context) {
    user =
        (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{})
            as User;
    // final profileUpdateBloc = context.read<ProfileUpdateBloc>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.lime, Colors.white],
            ),
          ),
        ),
        foregroundColor: Colors.black,
        title: const Text(
          "Editar Perfil",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage("assets/img/profile_background.jpg"),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          BlocListener<ProfileUpdateBloc, ProfileUpdateState>(
            listener: (context, state) {
              late UserResponse? userResponse = state.response;
              if (userResponse != null) {
                if (!userResponse.ok) {
                  Fluttertoast.showToast(
                    msg: userResponse.msg,
                    backgroundColor: Color.fromRGBO(255, 0, 0, 0.5),
                    textColor: Colors.white,
                  );
                } else {
                  User user = userResponse.user!;
                  Fluttertoast.showToast(
                    msg: userResponse.msg,
                    backgroundColor: Color.fromRGBO(0, 255, 0, 0.5),
                  );
                  context.read<ProfileUpdateBloc>().add(
                    UpdateUserSesion(user: user),
                  );
                  Future.delayed(Duration(seconds: 1), () {
                    context.read<ProfileInfoBloc>().add(GetUserEvent());
                  });
                }
              }
            },
            child: BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
              builder: (context, state) {
                return ProfileUpdateContent(user: user!, state: state);
              },
            ),
          ),
        ],
      ),
    );
  }
}
