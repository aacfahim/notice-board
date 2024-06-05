import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notice_board/features/home/model/tutor_model.dart';
import 'package:notice_board/features/tutor/repos/tutor_services.dart';

part 'tutor_event.dart';
part 'tutor_state.dart';

class TutorBloc extends Bloc<TutorEvent, TutorState> {
  TutorBloc() : super(TutorInitial()) {
    on<TutorInitialFetchEvent>(tutorInitialFetchEvent);
  }

  FutureOr<void> tutorInitialFetchEvent(
      TutorInitialFetchEvent event, Emitter<TutorState> emit) async {
    emit(TutorLoadingState());
    List<TutorDataModel> tutorList = await TutorServices.fetchTutorList();
    print("Tutors fetched");

    emit(TutorFetchSuccessfulState(tutorList: tutorList));
  }
}
