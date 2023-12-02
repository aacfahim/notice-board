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
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("See all")
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                      width: double.infinity,
                      height: height * .2,
                      child: Center(
                        child: Container(
                          height: 150,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 20,
                            itemBuilder: (index, context) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CategoryTile(
                                  noticesCount: 30,
                                  title: "Hello world",
                                ),
                              );
                            },
                            separatorBuilder: (index, context) =>
                                SizedBox(width: 15),
                          ),
                        ),
                      )),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Notice",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("See all")
                    ],
                  ),
                  SizedBox(
                    // height: double.maxFinite,
                    height: height * 0.5,

                    child: ListView.separated(
                        itemBuilder: (index, context) {
                          return NoticeTile(
                            title:
                                "বাংলাদেশ হাউজ বিল্ডিং ফাইনান্স কর্পোরেশন এর নিয়োগ পরিক্ষা সময়সূচী - ০৮/০৯ ",
                            noticeType: "Exam Notice",
                            date: "25 Aug 2023",
                          );
                        },
                        separatorBuilder: (index, context) =>
                            SizedBox(height: 12),
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
