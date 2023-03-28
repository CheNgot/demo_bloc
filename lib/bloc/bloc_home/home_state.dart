abstract class HomeState {}


class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> items;
  HomeLoaded({required this.items});
}

class HomeFailure extends HomeState {
  final String error;

  HomeFailure({required this.error});
}
