import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/auth_use_cases.dart';
import 'package:indrive_flutter_client/src/domain/models/user.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';

part 'profile_info_event.dart';
part 'profile_info_state.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  AuthUseCases authUseCases;
  ProfileInfoBloc(this.authUseCases) : super(ProfileInfoState()) {
    on<GetUserEvent>((event, emit) async {
      UserResponse userResponse = await authUseCases.getSession.run();
      // inspect(userResponse);
      if (userResponse.ok) {
        emit(
          state.copyWith(
            user: userResponse.user,
            profileInfoStatus: ProfileInfoStatus.success,
          ),
        );
      } else {
        emit(state.copyWith(profileInfoStatus: ProfileInfoStatus.error));
      }
    });
  }
}
