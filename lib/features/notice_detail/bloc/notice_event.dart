part of 'notice_bloc.dart';

@immutable
sealed class NoticeEvent {}

class HomeInitialNoticeFetchEvent extends NoticeEvent {}
