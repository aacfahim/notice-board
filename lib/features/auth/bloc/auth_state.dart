part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthFailedState extends AuthState {}

class AuthSuccessfullState extends AuthState {}
