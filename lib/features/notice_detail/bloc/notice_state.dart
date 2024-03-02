part of 'notice_bloc.dart';

@immutable
sealed class NoticeState {}

final class NoticeInitial extends NoticeState {}

final class HomeNoticeLoadingState extends NoticeState {}

final class CategorizedNoticeLoadingState extends NoticeState {}

class HomeNoticeFetchSuccessfulState extends NoticeState {
  final List<NoticeDataModel> notices;

  HomeNoticeFetchSuccessfulState({required this.notices});
}

class CategorizedFetchSuccessfulState extends NoticeState {
  final List<NoticeDataModel> notices;

  CategorizedFetchSuccessfulState({required this.notices});
}

final class HomeNoticeErrorState extends NoticeState {}
