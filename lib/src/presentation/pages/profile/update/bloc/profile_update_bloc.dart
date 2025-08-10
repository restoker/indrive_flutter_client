import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:indrive_flutter_client/src/presentation/utils/bloc_form_item.dart';

part 'profile_update_event.dart';
part 'profile_update_state.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  ProfileUpdateBloc() : super(ProfileUpdateInitial()) {
    on<ProfileUpdateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
