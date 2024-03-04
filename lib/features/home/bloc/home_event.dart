part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialFetchEvent extends HomeEvent {}

class HomePreferredFetchEvent extends HomeEvent {}

class HomeCategorySeeAllEvent extends HomeEvent {}

class HomeNoticeSeeAllEvent extends HomeEvent {}

class HomePreferredNoticeSeeAllEvent extends HomeEvent {}
