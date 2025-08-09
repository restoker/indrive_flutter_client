import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/auth_use_cases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final formkey = GlobalKey<FormState>();
  AuthUseCases authUseCases;

  HomeBloc(this.authUseCases) : super(HomeState()) {
    on<ChangeIndexEvent>((event, emit) {
      emit(state.copyWith(pageIndex: event.indexPage, formkey: formkey));
    });

    on<LogoutEvent>((event, emit) async {
      // await authUseCases.logout.run();
    });
  }
}
