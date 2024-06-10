import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notice_board/features/auth/repos/auth_repo.dart';
import 'package:notice_board/features/more/ui/preference_list/model/preference_notifier.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthInitialEvent>(authInitialEvent);
  }

  FutureOr<void> authInitialEvent(
      AuthInitialEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    await AuthRepo.localLogin();
    await PreferenceNotifier().loadPreference();
    emit(AuthSuccessfullState());
  }
}
