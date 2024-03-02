import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notice_board/features/home/model/notice_tile_model.dart';
import 'package:notice_board/features/home/repos/notice_services.dart';

part 'notice_event.dart';
part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  NoticeBloc() : super(NoticeInitial()) {
    on<HomeInitialNoticeFetchEvent>(homeInitialNoticeFetchEvent);
    on<HomeNoticeErrorEvent>(homeNoticeErrorEvent);
    on<CategorizedNoticeFetchEvent>(categorizedNoticeFetchEvent);
  }

  FutureOr<void> homeInitialNoticeFetchEvent(
      HomeInitialNoticeFetchEvent event, Emitter<NoticeState> emit) async {
    ///NOTICE TILE
    emit(HomeNoticeLoadingState());
    List<NoticeDataModel> notices = await NoticeServices.fetchNoticeTile();
    print("Notice Fetched");

    emit(HomeNoticeFetchSuccessfulState(notices: notices));
  }

  FutureOr<void> homeNoticeErrorEvent(
      HomeNoticeErrorEvent event, Emitter<NoticeState> emit) {
    emit(HomeNoticeErrorState());
    print("Notice Error state");
  }

  Future<void> categorizedNoticeFetchEvent(
      CategorizedNoticeFetchEvent event, Emitter<NoticeState> emit) async {
    emit(CategorizedNoticeLoadingState());
    try {
      List<NoticeDataModel> notices =
          await NoticeServices.fetchCategorizedNoticeTile(event.category);
      print("Categorized Notice Fetched");
      emit(CategorizedFetchSuccessfulState(notices: notices));
    } catch (e) {
      print("Exception occured " + e.toString());
    }
  }
}
