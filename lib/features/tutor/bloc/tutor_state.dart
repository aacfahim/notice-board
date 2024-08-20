part of 'tutor_bloc.dart';

@immutable
sealed class TutorState {}

final class TutorInitial extends TutorState {}

final class TutorLoadingState extends TutorState {}

class TutorFetchSuccessfulState extends TutorState {
  final List<TutorDataModel> tutorList;

  TutorFetchSuccessfulState({required this.tutorList});
}
