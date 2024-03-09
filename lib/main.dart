import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notice_board/features/auth/bloc/auth_bloc.dart';
import 'package:notice_board/features/auth/repos/auth_repo.dart';
import 'package:notice_board/features/home/model/preference_notifier.dart';
import 'package:notice_board/features/home/repos/preferred_degree_dropdown.dart';
import 'package:notice_board/features/home/ui/custom_navbar.dart';
import 'package:notice_board/features/home/ui/home.dart';
import 'package:notice_board/features/notice_detail/ui/notice_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AuthBloc authBloc = AuthBloc();
  authBloc.add(AuthInitialEvent());

  // PreferredDegree.fetchDegreeDropdown();

  // AuthRepo().getDeviceId();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PreferenceModel(),
      child: MaterialApp(
        title: 'Notice Board App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff246BFD)),
          primaryColor: Color(0xff246BFD),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.rubikTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: CustomBottomNavigationBar(),
      ),
    );
  }
}
