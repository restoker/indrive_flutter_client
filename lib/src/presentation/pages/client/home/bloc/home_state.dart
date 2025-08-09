part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int pageIndex;
  final GlobalKey<FormState>? formkey;

  const HomeState({this.pageIndex = 0, this.formkey});

  HomeState copyWith({int? pageIndex, GlobalKey<FormState>? formkey}) {
    return HomeState(
      pageIndex: pageIndex ?? this.pageIndex,
      formkey: formkey ?? this.formkey,
    );
  }

  @override
  List<Object> get props => [pageIndex];
}
