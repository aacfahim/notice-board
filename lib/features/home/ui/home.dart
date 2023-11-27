import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notice_board/features/home/ui/widgets/criteria_widget.dart';
import 'package:notice_board/features/home/ui/widgets/home_appbar.dart';

import '../../../utils/const.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xffF5F6F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeAppBar(subtitle: "Let's see the update notice"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                //shrinkWrap: true,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    height: height * 0.20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: CriteriaWidget(),
                  ),
                  Text("data"),
                  Text("data"),
                  Text("data"),
                  Text("data"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
