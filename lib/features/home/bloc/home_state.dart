part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeCategoryLoadingState extends HomeState {}

final class HomeNoticeTileLoadingState extends HomeState {}

final class HomeNoticeLoadingState extends HomeState {}

class HomeNoticeFetchSuccessfulState extends HomeState {}

class HomeNoticeTileFetchSuccessfulState extends HomeState {
  final List<NoticeTileDataModel> notices;

  HomeNoticeTileFetchSuccessfulState({required this.notices});
}

class HomeCategoryFetchSuccessfulState extends HomeState {
  final List<CategoryDataModel> categories;

  HomeCategoryFetchSuccessfulState({required this.categories});
}

class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState({required this.error});
}
