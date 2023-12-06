import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notice_board/features/auth/bloc/auth_bloc.dart';
import 'package:notice_board/features/home/model/category_model.dart';
import 'package:notice_board/features/home/model/notice_tile_model.dart';
import 'package:notice_board/features/home/repos/category_services.dart';
import 'package:notice_board/features/home/repos/notice_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AuthBloc authBloc = AuthBloc();

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialFetchEvent>(homeInitialFetchEvent);
  }

  FutureOr<void> homeInitialFetchEvent(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    try {
      ///CATEGORY TILE
      emit(HomeCategoryLoadingState());
      List<CategoryDataModel> categories =
          await CategoryServices.fetchCategory();
      print("Category Fetched");

      emit(HomeCategoryFetchSuccessfulState(categories: categories));

      ///NOTICE TILE
      emit(HomeNoticeTileLoadingState());
      List<NoticeTileDataModel> notices =
          await NoticeServices.fetchNoticeTile();
      print("Notice Fetched");

      emit(HomeNoticeTileFetchSuccessfulState(notices: notices));
    } catch (e) {
      // Handle errors here and emit an error state if needed
      emit(HomeErrorState(error: e.toString()));
    }
  }
}
