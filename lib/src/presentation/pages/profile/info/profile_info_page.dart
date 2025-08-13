import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/profile/info/bloc/profile_info_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/profile/info/profile_info_content.dart';

class ProfileInfoPage extends StatelessWidget {
  const ProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white, // Starting color
                  Colors.lime.shade100, // Ending color
                ],
                begin: Alignment.topCenter, // Gradient starts at top center
                end: Alignment.bottomCenter, // Gradient ends at bottom center
              ),
            ),
            child: ProfileInfoContent(),
          ),
        );
      },
    );
  }
}
