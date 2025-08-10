part of 'home_bloc.dart';

enum HomePageStatus { valid, invalid, error }

class HomeState extends Equatable {
  final int pageIndex;
  final GlobalKey<FormState>? formkey;
  final HomePageStatus homePageStatus;

  const HomeState({
    this.pageIndex = 0,
    this.formkey,
    this.homePageStatus = HomePageStatus.invalid,
  });

  HomeState copyWith({
    int? pageIndex,
    GlobalKey<FormState>? formkey,
    HomePageStatus? homePageStatus,
  }) {
    return HomeState(
      pageIndex: pageIndex ?? this.pageIndex,
      formkey: formkey ?? this.formkey,
      homePageStatus: homePageStatus ?? this.homePageStatus,
    );
  }

  @override
  List<Object> get props => [pageIndex, homePageStatus];
}
