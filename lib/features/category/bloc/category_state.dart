part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class HomeCategoryLoadingState extends CategoryState {}

class HomeCategoryFetchSuccessfulState extends CategoryState {
  final List<CategoryDataModel> categories;

  HomeCategoryFetchSuccessfulState({required this.categories});
}
