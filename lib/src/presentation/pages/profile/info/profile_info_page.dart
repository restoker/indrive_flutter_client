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
        return Scaffold(body: ProfileInfoContent());
      },
    );
  }
}
