part of 'notice_bloc.dart';

@immutable
sealed class NoticeState {}

final class NoticeInitial extends NoticeState {}

final class HomeNoticeLoadingState extends NoticeState {}

class HomeNoticeFetchSuccessfulState extends NoticeState {
  final List<NoticeTileDataModel> notices;

  HomeNoticeFetchSuccessfulState({required this.notices});
}

final class HomeNoticeErrorState extends NoticeState {}
