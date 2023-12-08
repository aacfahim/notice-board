import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notice_board/features/auth/bloc/auth_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AuthBloc authBloc = AuthBloc();

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialFetchEvent>(homeInitialFetchEvent);
    on<HomeCategorySeeAllEvent>(homeCategorySeeAllEvent);
    on<HomeNoticeSeeAllEvent>(homeNoticeSeeAllEvent);
  }

  FutureOr<void> homeInitialFetchEvent(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    try {} catch (e) {
      // Handle errors here and emit an error state if needed
      emit(HomeErrorState(error: e.toString()));
    }
  }

  FutureOr<void> homeCategorySeeAllEvent(
      HomeCategorySeeAllEvent event, Emitter<HomeState> emit) {
    print("HomeCategorySeeAllActionState");
    emit(HomeCategorySeeAllActionState());
  }

  FutureOr<void> homeNoticeSeeAllEvent(
      HomeNoticeSeeAllEvent event, Emitter<HomeState> emit) {
    print("HomeNoticeSeeAllActionState");
    emit(HomeNoticeSeeAllActionState());
  }
}
