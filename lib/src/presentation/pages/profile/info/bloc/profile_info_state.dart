part of 'profile_info_bloc.dart';

enum ProfileInfoStatus { initial, loading, success, error }

class ProfileInfoState extends Equatable {
  final User? user;
  final ProfileInfoStatus profileInfoStatus;

  const ProfileInfoState({
    this.user,
    this.profileInfoStatus = ProfileInfoStatus.initial,
  });

  ProfileInfoState copyWith({
    User? user,
    ProfileInfoStatus? profileInfoStatus,
  }) {
    return ProfileInfoState(
      user: user ?? this.user,
      profileInfoStatus: profileInfoStatus ?? this.profileInfoStatus,
    );
  }

  @override
  List<Object> get props => [profileInfoStatus];
}
