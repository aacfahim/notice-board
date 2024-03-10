import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/features/auth/bloc/auth_bloc.dart';
import 'package:notice_board/features/common/ui/splash_screen.dart';
import 'package:notice_board/features/home/ui/custom_navbar.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return SplashScreen();
        } else if (state is AuthSuccessfullState) {
          return CustomBottomNavigationBar();
        } else {
          return Container(); // Handle other states or errors
        }
      },
    );
  }
}
