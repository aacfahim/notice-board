import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notice_board/features/auth/bloc/auth_bloc.dart';
import 'package:notice_board/features/home/model/category_model.dart';
import 'package:notice_board/features/home/repos/category_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AuthBloc authBloc = AuthBloc();

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialFetchEvent>(homeInitialFetchEvent);
  }

  FutureOr<void> homeInitialFetchEvent(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeCategoryLoadingState());
    List<CategoryDataModel> categories = await CategoryServices.fetchCategory();
    emit(HomeCategoryFetchSuccessfulState(categories: categories));
  }
}
