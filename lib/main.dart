import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notice_board/features/auth/bloc/auth_bloc.dart';
import 'package:notice_board/features/auth/ui/auth_screen.dart';
import 'package:notice_board/features/home/model/preference_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        ).copyWith(
            textTheme:
                GoogleFonts.creteRoundTextTheme(Theme.of(context).textTheme)),
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
            create: (context) => AuthBloc()..add(AuthInitialEvent()),
            child: AuthScreen()),
      ),
    );
  }
}
