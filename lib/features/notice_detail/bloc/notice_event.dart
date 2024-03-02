part of 'notice_bloc.dart';

@immutable
sealed class NoticeEvent {}

class HomeInitialNoticeFetchEvent extends NoticeEvent {}

class CategorizedNoticeFetchEvent extends NoticeEvent {
  final String category;

  CategorizedNoticeFetchEvent(this.category);
}

class HomeNoticeErrorEvent extends NoticeEvent {}
