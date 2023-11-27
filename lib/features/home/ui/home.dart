import 'package:flutter/material.dart';
import 'package:notice_board/features/home/ui/widgets/home_appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xffF5F6F7),
      body: Column(
        children: [
          HomeAppBar(subtitle: "Let's see the update notice"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
        ],
      ),
    );
  }
}
