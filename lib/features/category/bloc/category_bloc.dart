import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notice_board/features/home/model/category_model.dart';
import 'package:notice_board/features/home/repos/category_services.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<HomeInitialCategoryFetchEvent>(homeInitialCategoryFetchEvent);
  }

  FutureOr<void> homeInitialCategoryFetchEvent(
      HomeInitialCategoryFetchEvent event, Emitter<CategoryState> emit) async {
    ///CATEGORY TILE
    emit(HomeCategoryLoadingState());
    List<CategoryDataModel> categories = await CategoryServices.fetchCategory();
    print("Category Fetched");

    emit(HomeCategoryFetchSuccessfulState(categories: categories));
  }
}
