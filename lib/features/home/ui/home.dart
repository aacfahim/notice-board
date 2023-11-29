import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notice_board/features/home/ui/widgets/categories_tile.dart';
import 'package:notice_board/features/home/ui/widgets/criteria_widget.dart';
import 'package:notice_board/features/home/ui/widgets/home_appbar.dart';
import 'package:notice_board/features/home/ui/widgets/notice_tile.dart';

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
    double width = MediaQuery.of(context).size.width;

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
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    // height: height * 0.20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: CriteriaWidget(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Categories"),
                      TextButton(
                          onPressed: () {}, child: const Text("Seel all"))
                    ],
                  ),
                  SizedBox(
                    // color: Colors.red,
                    height: height * 0.155,
                    // height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                            title: "All Notices", noticesCount: 35);
                      },
                      separatorBuilder: (context, index) => SizedBox(width: 40),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("My Notice"),
                      TextButton(
                          onPressed: () {}, child: const Text("Seel all"))
                    ],
                  ),
                  SizedBox(
                    // height: double.maxFinite,
                    height: height * 0.5,

                    child: ListView.separated(
                        itemBuilder: (index, context) {
                          return NoticeTile();
                        },
                        separatorBuilder: (index, context) =>
                            SizedBox(height: 6),
                        itemCount: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
