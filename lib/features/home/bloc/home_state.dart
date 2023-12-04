part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeLoadingState extends HomeState {}

class HomeNoticeFetchSuccessfulState extends HomeState {}

class HomeCategoryFetchSuccessfulState extends HomeState {
  final List<CategoryModel> categories;

  HomeCategoryFetchSuccessfulState({required this.categories});
}
