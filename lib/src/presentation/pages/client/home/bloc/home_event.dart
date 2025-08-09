part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class ChangeIndexEvent extends HomeEvent {
  final int indexPage;
  ChangeIndexEvent({required this.indexPage});
}

class LogOutEvent extends HomeEvent {}
