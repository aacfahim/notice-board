import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notice_board/features/auth/bloc/auth_bloc.dart';
import 'package:notice_board/features/home/bloc/home_bloc.dart';
import 'package:notice_board/features/home/ui/widgets/categories_tile.dart';
import 'package:notice_board/features/home/ui/widgets/category_tile_shimmer.dart';
import 'package:notice_board/features/home/ui/widgets/criteria_widget.dart';
import 'package:notice_board/features/home/ui/widgets/home_appbar.dart';
import 'package:notice_board/features/home/ui/widgets/notice_tile.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/const.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialFetchEvent());
    super.initState();
  }

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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
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
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("See all")
                    ],
                  ),
                ),
                SizedBox(height: height * 0.01),
                BlocConsumer<HomeBloc, HomeState>(
                  bloc: homeBloc,
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case HomeCategoryLoadingState:
                        return Container(
                          height: 150,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 20,
                              itemBuilder: (index, context) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child:
                                      CategoryTileShimmer(), // Create a CategoryTileShimmer widget
                                );
                              },
                              separatorBuilder: (index, context) =>
                                  SizedBox(width: 15),
                            ),
                          ),
                        );
                      case HomeCategoryFetchSuccessfulState:
                        final categorySuccessState =
                            state as HomeCategoryFetchSuccessfulState;
                        print(categorySuccessState.categories.length);
                        return Container(
                            // padding: const EdgeInsets.only(left: 10),

                            width: double.infinity,
                            height: height * .2,
                            child: Center(
                              child: Container(
                                height: 150,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      categorySuccessState.categories.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: CategoryTile(
                                          noticesCount: 30,
                                          title: categorySuccessState
                                              .categories[index]
                                              .attributes!
                                              .name
                                              .toString()
                                          // title: "Hello",
                                          ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 15),
                                ),
                              ),
                            ));
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Notice",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("See all")
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: height * 0.5,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
