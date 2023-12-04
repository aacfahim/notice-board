import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notice_board/features/home/ui/custom_navbar.dart';
import 'package:notice_board/features/home/ui/home.dart';
import 'package:notice_board/features/notice_detail/ui/notice_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
